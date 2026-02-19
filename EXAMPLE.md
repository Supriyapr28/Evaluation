# Example: Configuring a Single Submodule

This example demonstrates how to configure one submodule when you know its URL.

## Scenario

Let's say you found that `b2r_oli_ev` is available at:
```
https://github.com/username/b2r_oli_ev.git
```

## Step-by-Step Process

### Step 1: Create or Edit .gitmodules

Create a `.gitmodules` file (if it doesn't exist):

```bash
touch .gitmodules
```

Add the submodule configuration:

```ini
[submodule "b2r_oli_ev"]
    path = b2r_oli_ev
    url = https://github.com/username/b2r_oli_ev.git
```

### Step 2: Initialize the Submodule

Tell git about this submodule:

```bash
git submodule init b2r_oli_ev
```

Expected output:
```
Submodule 'b2r_oli_ev' (https://github.com/username/b2r_oli_ev.git) registered for path 'b2r_oli_ev'
```

### Step 3: Fetch the Content

Download the submodule content:

```bash
git submodule update b2r_oli_ev
```

Expected output:
```
Cloning into '/path/to/Evaluation/b2r_oli_ev'...
Submodule path 'b2r_oli_ev': checked out '4fd1ce6c486dda4ddeb54697141f7bb25334d1d6'
```

### Step 4: Verify

Check that the content is now available:

```bash
ls -la b2r_oli_ev/
```

You should now see files instead of an empty directory!

### Step 5: Check Status

Verify the submodule is properly configured:

```bash
git submodule status b2r_oli_ev
```

Expected output:
```
 4fd1ce6c486dda4ddeb54697141f7bb25334d1d6 b2r_oli_ev (heads/master)
```

Or use the helper script:

```bash
bash manage-submodules.sh check
```

## Complete .gitmodules Example

Here's how `.gitmodules` would look with multiple submodules configured:

```ini
[submodule "b2r_oli_ev"]
    path = b2r_oli_ev
    url = https://github.com/user1/b2r_oli_ev.git

[submodule "ev_born2R"]
    path = ev_born2R
    url = https://github.com/user2/ev_born2R.git

[submodule "ev_tracy_libft"]
    path = ev_tracy_libft
    url = https://github.com/user3/libft.git

# Add more submodules as needed...
```

## Initialize All Configured Submodules

Once you have multiple submodules configured:

```bash
# Initialize all submodules
git submodule init

# Fetch content for all
git submodule update --init --recursive
```

## Common Issues

### Issue: "fatal: not a git repository"

**Problem**: The directory was not properly initialized.

**Solution**: Remove the directory and try again:
```bash
rm -rf b2r_oli_ev
git submodule update --init b2r_oli_ev
```

### Issue: "Cloning into ... Permission denied"

**Problem**: Private repository requires authentication.

**Solution**: Ensure you have access rights and are authenticated:
```bash
# For HTTPS with credentials
git config --global credential.helper cache

# Or use SSH URLs instead
url = git@github.com:username/b2r_oli_ev.git
```

### Issue: "reference is not a tree"

**Problem**: The commit SHA in the repository doesn't exist in the submodule.

**Solution**: Either:
1. Use a different commit/branch
2. Verify the URL is correct
3. Contact the repository owner

## Testing Your Configuration

Use the helper script to validate:

```bash
# Check overall status
bash manage-submodules.sh check

# Validate URLs (if configured)
bash manage-submodules.sh validate-urls

# List all submodules
bash manage-submodules.sh list
```

## Next Steps

After successfully configuring one submodule:

1. Repeat for other submodules you need
2. Commit the `.gitmodules` file:
   ```bash
   git add .gitmodules
   git commit -m "Add submodule configuration for b2r_oli_ev"
   ```
3. Share the configuration with your team

## Alternative: Using git submodule add

If you're adding a brand new submodule (not already tracked):

```bash
# This will automatically:
# 1. Clone the repository
# 2. Update .gitmodules
# 3. Register the submodule
git submodule add https://github.com/username/repo.git path/to/submodule
```

However, since the submodules in this repository are already tracked, use the manual `.gitmodules` approach instead.

## Reference

For more information:
- See `README.md` for comprehensive documentation
- See `TROUBLESHOOTING.md` for common problems
- Run `git help submodule` for git documentation
