# Quick Start Guide

## The Problem
You cloned this repository but all the project directories are **empty**. This is because they are git submodules without configured URLs.

## Quick Diagnosis

Run this command to check the status:
```bash
bash manage-submodules.sh check
```

## What You Need

To access the project content, you need **the original repository URLs** for each submodule.

## Solutions (Choose One)

### Option A: Get the URLs from Repository Owner ⭐ RECOMMENDED

1. Contact the repository maintainer
2. Request the `.gitmodules` file or submodule URLs
3. Place `.gitmodules` in the repository root
4. Run:
   ```bash
   git submodule init
   git submodule update --init --recursive
   ```

### Option B: Search for Repositories on GitHub

1. Get a list of commit SHAs:
   ```bash
   bash manage-submodules.sh list
   ```

2. Search GitHub for each commit SHA
3. Add found repositories as submodules:
   ```bash
   git submodule add <url> <path>
   ```

### Option C: Use Existing .gitmodules

If you already have a `.gitmodules` file:

1. Place it in the repository root
2. Run:
   ```bash
   git submodule init
   git submodule update --init --recursive
   ```

### Option D: Manual Configuration

1. Copy the template:
   ```bash
   cp .gitmodules.template .gitmodules
   ```

2. Edit `.gitmodules` and replace `<URL_NEEDED>` with actual URLs

3. Uncomment the submodule sections you configured

4. Initialize:
   ```bash
   git submodule init
   git submodule update --init --recursive
   ```

## Verification

After applying a solution, verify the content is accessible:

```bash
# Check a specific directory
ls -la b2r_oli_ev/

# Check all submodules
bash manage-submodules.sh check

# View submodule status
git submodule status
```

## Still Stuck?

1. Read the full [README.md](README.md)
2. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues
3. Run `bash manage-submodules.sh info` for detailed information

## Key Files

- **README.md** - Complete documentation
- **TROUBLESHOOTING.md** - Solutions for common problems
- **manage-submodules.sh** - Helper script for managing submodules
- **.gitmodules.template** - Template for configuring submodules

## Understanding the Structure

This repository has **37 submodules**:
- 7 top-level project evaluations
- 30 piscine evaluations in `piscine_ev/`

Each is a separate git repository referenced at a specific commit.

## Important Notes

⚠️ **Without .gitmodules file**: Submodules cannot be initialized  
⚠️ **Private repositories**: May require authentication  
⚠️ **Missing URLs**: Cannot fetch content automatically  

✅ **With proper .gitmodules**: All content can be fetched with one command  
✅ **Helper script available**: Use `manage-submodules.sh` to check status  
✅ **Template provided**: `.gitmodules.template` shows required format  
