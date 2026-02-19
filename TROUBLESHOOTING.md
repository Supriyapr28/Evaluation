# Troubleshooting Guide for Empty Project Directories

This guide helps you resolve issues with accessing project content in this repository.

## Problem: "Nothing is inside the projects"

### Understanding the Issue

You're seeing empty directories because this repository uses **git submodules**, which are references to external repositories. Without the proper configuration, git cannot fetch the actual content.

**Quick Check:**
```bash
# Run this to see submodule status
bash manage-submodules.sh check

# Or check manually
git ls-files --stage | grep "^160000"
```

## Solutions

### Solution 1: Request the Original Configuration (Recommended)

The repository owner should have the original `.gitmodules` file that contains the URLs for all submodules.

**Steps:**
1. Contact the repository maintainer
2. Request the `.gitmodules` file or the original submodule URLs
3. Once you have it, place it in the repository root
4. Run:
   ```bash
   git submodule init
   git submodule update --init --recursive
   ```

### Solution 2: Search for the Original Repositories

If you know where these repositories might be hosted (e.g., GitHub):

1. Use the commit SHA to search:
   ```bash
   # Get the commit SHA for a specific submodule
   git ls-files --stage | grep "submodule_name"
   ```

2. Search on GitHub:
   - Go to GitHub search
   - Search for the commit SHA
   - If found, you'll see which repository it belongs to

3. Add as submodule:
   ```bash
   git submodule add <repository-url> <path>
   ```

### Solution 3: Use the Helper Script

We've included a management script to help you:

```bash
# Check current status
bash manage-submodules.sh check

# List all submodules with their commit SHAs
bash manage-submodules.sh list

# Get detailed information
bash manage-submodules.sh info

# Show help
bash manage-submodules.sh help
```

### Solution 4: Manual Configuration

If you have access to the original repositories:

1. Copy `.gitmodules.template` to `.gitmodules`:
   ```bash
   cp .gitmodules.template .gitmodules
   ```

2. Edit `.gitmodules` and replace `<URL_NEEDED>` with actual URLs:
   ```ini
   [submodule "b2r_oli_ev"]
       path = b2r_oli_ev
       url = https://github.com/username/b2r_oli_ev.git
   ```

3. Uncomment the sections you've configured

4. Initialize and update:
   ```bash
   git submodule init
   git submodule update --init --recursive
   ```

### Solution 5: Convert to Regular Directories

If submodules are not needed:

1. Remove submodule entries from git:
   ```bash
   git rm --cached b2r_oli_ev
   git rm --cached ev_born2R
   # ... repeat for each submodule
   ```

2. Copy the actual content into the directories

3. Add as regular files:
   ```bash
   git add b2r_oli_ev
   git commit -m "Convert submodule to regular directory"
   ```

## Common Errors

### Error: "fatal: no submodule mapping found in .gitmodules"

**Cause:** You tried to run `git submodule` commands without a `.gitmodules` file.

**Solution:** You need to create `.gitmodules` with proper URLs first (see Solution 4 above).

### Error: "Unable to checkout submodule"

**Cause:** The URL in `.gitmodules` is incorrect or inaccessible.

**Solution:** 
- Verify the URL is correct
- Check if you have access (private repositories need authentication)
- Try accessing the URL directly in your browser

### Warning: "Submodule path ... not initialized"

**Cause:** Submodules haven't been initialized yet.

**Solution:**
```bash
git submodule init
git submodule update
```

## Verification

After applying a solution, verify it worked:

```bash
# Check if directories have content now
ls -la b2r_oli_ev/
ls -la ev_born2R/

# Check submodule status
git submodule status

# Use the helper script
bash manage-submodules.sh check
```

## Prevention

To avoid this issue in the future:

1. **Always commit `.gitmodules`** when adding submodules
2. Document submodule sources in README
3. Keep a backup of `.gitmodules` file
4. Use relative URLs when possible for better portability

## Need More Help?

1. Review the main [README.md](README.md) for comprehensive information
2. Check git submodule documentation: `git help submodule`
3. Open an issue on the repository if you're stuck

## Quick Reference

### Git Submodule Commands

```bash
# Add a submodule
git submodule add <url> <path>

# Initialize submodules
git submodule init

# Update/fetch submodule content
git submodule update

# Clone repository with submodules
git clone --recursive <repository-url>

# Update existing clone
git submodule update --init --recursive

# Get submodule status
git submodule status

# Remove a submodule
git submodule deinit <path>
git rm <path>
```

### Helper Script Commands

```bash
# Check configuration
bash manage-submodules.sh check

# List all submodules
bash manage-submodules.sh list

# Show information
bash manage-submodules.sh info

# Validate URLs (requires .gitmodules)
bash manage-submodules.sh validate-urls
```
