#!/bin/bash

# Submodule Management Helper Script
# This script helps manage the submodules in this repository

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

show_help() {
    cat << EOF
Submodule Management Helper

Usage: $0 <command>

Commands:
    list            List all submodules and their status
    check           Check if .gitmodules file exists and is configured
    info            Show detailed information about submodules
    validate-urls   Validate if URLs in .gitmodules are accessible (requires .gitmodules)
    help            Show this help message

Examples:
    $0 list         # List all submodules
    $0 check        # Check configuration status
    $0 info         # Show detailed submodule information

Note: To initialize submodules, you first need a properly configured .gitmodules file.
      See README.md for more information.
EOF
}

list_submodules() {
    print_header "Submodule List"
    
    echo "Checking git index for submodule entries..."
    echo ""
    
    # Get submodule entries from git index
    git ls-files --stage | grep "^160000" | while read -r mode hash stage path; do
        if [ -d "$path" ] && [ ! "$(ls -A "$path" 2>/dev/null)" ]; then
            status="${RED}EMPTY${NC}"
        elif [ -d "$path" ] && [ "$(ls -A "$path" 2>/dev/null)" ]; then
            status="${GREEN}HAS CONTENT${NC}"
        else
            status="${YELLOW}MISSING${NC}"
        fi
        
        echo -e "  $path"
        echo -e "    Commit: $hash"
        echo -e "    Status: $status"
        echo ""
    done
    
    count=$(git ls-files --stage | grep "^160000" | wc -l)
    print_info "Total submodules: $count"
}

check_configuration() {
    print_header "Configuration Check"
    
    # Check if .gitmodules exists
    if [ -f ".gitmodules" ]; then
        print_success ".gitmodules file exists"
        
        # Check if it has content
        if [ -s ".gitmodules" ]; then
            print_success ".gitmodules file has content"
            
            # Count configured submodules
            configured=$(grep -c "^\[submodule" .gitmodules || echo "0")
            total=$(git ls-files --stage | grep "^160000" | wc -l)
            
            echo ""
            print_info "Configured submodules: $configured"
            print_info "Total submodules: $total"
            
            if [ "$configured" -eq "$total" ]; then
                print_success "All submodules are configured!"
            else
                print_warning "Not all submodules are configured ($configured/$total)"
            fi
        else
            print_error ".gitmodules file is empty"
            print_info "Use .gitmodules.template as a reference"
        fi
    else
        print_error ".gitmodules file does not exist"
        print_info "A template is available at .gitmodules.template"
        print_info "You need to create .gitmodules with proper URLs to access submodule content"
    fi
    
    echo ""
    
    # Check submodule status
    print_info "Checking submodule directories..."
    empty_count=0
    has_content_count=0
    
    git ls-files --stage | grep "^160000" | while read -r mode hash stage path; do
        if [ -d "$path" ]; then
            if [ ! "$(ls -A "$path" 2>/dev/null)" ]; then
                empty_count=$((empty_count + 1))
            else
                has_content_count=$((has_content_count + 1))
            fi
        fi
    done
    
    total=$(git ls-files --stage | grep "^160000" | wc -l)
    print_info "Empty directories: Finding..."
    print_info "Directories with content: Finding..."
}

show_info() {
    print_header "Detailed Submodule Information"
    
    echo "This repository contains $(git ls-files --stage | grep "^160000" | wc -l) submodules."
    echo ""
    echo "What are submodules?"
    echo "  Git submodules are references to other git repositories at specific commits."
    echo "  They appear as empty directories until initialized with 'git submodule update'."
    echo ""
    echo "Why are the directories empty?"
    echo "  1. Submodules need a .gitmodules file with repository URLs"
    echo "  2. The URLs must be accessible"
    echo "  3. Submodules must be initialized with 'git submodule init'"
    echo "  4. Content must be fetched with 'git submodule update'"
    echo ""
    echo "Current situation:"
    
    if [ ! -f ".gitmodules" ]; then
        echo "  ✗ .gitmodules file is missing"
        echo "  → Without this file, submodules cannot be initialized"
    else
        echo "  ✓ .gitmodules file exists"
    fi
    
    echo ""
    echo "What to do next:"
    echo "  1. Check README.md for detailed instructions"
    echo "  2. If you have the original URLs, create/update .gitmodules"
    echo "  3. Use .gitmodules.template as a reference"
    echo "  4. Run 'git submodule init && git submodule update' after configuring URLs"
}

validate_urls() {
    if [ ! -f ".gitmodules" ]; then
        print_error ".gitmodules file not found"
        print_info "Cannot validate URLs without .gitmodules file"
        return 1
    fi
    
    print_header "Validating Submodule URLs"
    print_warning "This feature requires network access and proper git credentials"
    echo ""
    
    # Parse .gitmodules and try to validate each URL
    grep "^\[submodule" .gitmodules | while read -r line; do
        submodule_name=$(echo "$line" | sed 's/\[submodule "\(.*\)"\]/\1/')
        path=$(git config -f .gitmodules "submodule.$submodule_name.path")
        url=$(git config -f .gitmodules "submodule.$submodule_name.url")
        
        if [ -z "$url" ] || [ "$url" = "<URL_NEEDED>" ]; then
            print_warning "$submodule_name: URL not configured"
        else
            echo -n "Checking $submodule_name ($url)... "
            if git ls-remote "$url" HEAD &>/dev/null; then
                print_success "accessible"
            else
                print_error "not accessible or requires authentication"
            fi
        fi
    done
}

# Main command dispatcher
case "${1:-help}" in
    list)
        list_submodules
        ;;
    check)
        check_configuration
        ;;
    info)
        show_info
        ;;
    validate-urls)
        validate_urls
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac
