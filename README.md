# Evaluation Repository

This repository contains evaluation projects organized as git submodules. Each subdirectory represents a separate project repository.

## Understanding the Issue

The directories in this repository appear empty because they are **git submodules** that have not been properly configured with their source URLs. Git tracks these as submodule references (commit SHA hashes) but cannot fetch the actual content without knowing where to retrieve it from.

### Current Structure

The repository contains 37 submodules organized as follows:

#### Top-level Projects
- `b2r_oli_ev`
- `ev_born2R`
- `ev_tracy_libft`
- `ev_yudi_libft`
- `ft_printf_mai_ev`
- `libft_taali_ev`
- `push_swap_nikita_ev`

#### Piscine Evaluations (`piscine_ev/`)
Contains 30 evaluation projects for various students and assignments.

## Why Are the Directories Empty?

When you clone this repository, you'll notice that all project directories are empty. This happens because:

1. **Submodules are Git references**: Git stores submodules as commit SHA references, not actual file contents
2. **Missing `.gitmodules` file**: This file normally contains the URLs where submodule content can be fetched from
3. **Submodules not initialized**: Without proper URLs, `git submodule init` and `git submodule update` cannot retrieve the content

## How to Access the Project Data

Since the original submodule URLs are not available in this repository, you have several options:

### Option 1: Check if URLs are available elsewhere
The original repository owner may have the source URLs for these submodules. Contact them to obtain:
- The original `.gitmodules` file
- The remote repository URLs for each project

### Option 2: Extract commit information
Each submodule is pinned to a specific commit. You can see these commits:

```bash
git ls-files --stage | grep 160000
```

This shows the commit SHA for each submodule. If you know where the original repositories are hosted, you can:

```bash
# For each submodule, if you know the URL:
git submodule add <repository-url> <path>
git submodule update --init <path>
```

### Option 3: Manual recreation
If the submodules are available in other locations (GitHub, GitLab, etc.):

1. Find the original repositories
2. Add them as submodules with correct URLs:
```bash
git submodule add https://github.com/user/repo.git path/to/submodule
```
3. Checkout the specific commits referenced in this repository

### Option 4: Convert to regular directories
If you have the content from another source, you can:

1. Remove submodule entries:
```bash
git rm --cached <submodule-path>
```
2. Add the actual content as regular files:
```bash
cp -r /path/to/actual/content <submodule-path>
git add <submodule-path>
```

## Submodule List

Below is the complete list of submodules in this repository with their tracked commit SHA:

```
b2r_oli_ev                      @ 4fd1ce6c486dda4ddeb54697141f7bb25334d1d6
ev_born2R                       @ da203009fdd22b5efafb3b7169936c72d744cce1
ev_tracy_libft                  @ eac38af116b02bf6a2ff14cb9e7500ead14d6f72
ev_yudi_libft                   @ b3d5e9a085693d6f1c5eab1d170290a47508f896
ft_printf_mai_ev                @ 712f207cee67d1ac7b7bc18fb90886b7dc8dfb0f
libft_taali_ev                  @ 835d8d289c550e9f40f3241e834862e4ca469b89
piscine_ev/C00_lupelleg_ev      @ d3d134b516e14fad1b7b932545c1c3562484e7f3
piscine_ev/C06_nashena_ev       @ 1f05caebb42fc254a546c040d7c54b545855f651
piscine_ev/C08_tengl_ev         @ 490196b43418ed19a575b46d95f60998184f3a21
piscine_ev/C09_tony_ev          @ d89d245f374a08f6823f73e6198e3fc1684e32b0
piscine_ev/C11_sinan_ev         @ 2dbd66c48ea2de5b6175c5325726414224c33c88
piscine_ev/C11_thundin_ev       @ 4f29e281b32ef93250ace91d2f8bf50c8d9104cd
piscine_ev/alex_ev              @ 119d599cf0a9866cda93d8c795fb7b48e48df9c3
piscine_ev/angela_ev            @ 7181b6650f1b005a3008f2f96a7a820ecb32ae25
piscine_ev/arnela_ev            @ 98c3153fed02fa107115b668ee39d2bb4ebefc84
piscine_ev/astaria_ev           @ f0b5ccbbd5d261751f757343643f7d6910643fa9
piscine_ev/c08_aganzler_ev      @ 2c9ef223796b5419c12cf13d1dfc54b4b0b59ba2
piscine_ev/cfauq_ev             @ 2f9693b228e751351329bbcca956cabdd1be6d98
piscine_ev/daniel_ev            @ 8c88de197857f18d64d31519bafbcc44d6292881
piscine_ev/dstreck_ev           @ 8c88de197857f18d64d31519bafbcc44d6292881
piscine_ev/dvel_ev              @ 84677015a5f148290f05dcbd42aa8f808838f642
piscine_ev/elisa_ev             @ a51df8d27303012cfe96eab9449893638b464fc5
piscine_ev/eval                 @ 309922ecbfd26d7b577edede7fee141d6bd177ca
piscine_ev/fred_ev              @ ecce42f180a7baaf56461d8636006529cbc6df3c
piscine_ev/hassain_ev           @ 4237df553ce2e2ffa3f5646a632e0be013eb03a2
piscine_ev/jonas_ev             @ e9b0c21c89a600f82f468f45d136fec167668f2a
piscine_ev/luna_ev              @ b7884c59fc9d0b4aabe37631145c4b4ad9d4be63
piscine_ev/natalia_ev           @ 53cf5b2361878aaf01bdbdd7ff5d27c4eae52e55
piscine_ev/oscar_ev             @ 8e71a18d73960752d6ccf8ca93662ae2e7f4282e
piscine_ev/pavel_ev             @ 77f79cc5a7eb5af4d083fba2247bee89fc179f4c
piscine_ev/simon_ev             @ 02de30ffdf86fb97e3a50d47bdf034c9ba7a5989
piscine_ev/thomas_ev            @ 03af3a75e770967abba7812c242ebb668f9f6f26
piscine_ev/thudinh_ev           @ 9ac5b43d38ae211dc4d1744a5999d16347a4a0ae
piscine_ev/vishnu_ev            @ cadea100b728c2eccb1c90c8dec04bfdb35244c4
piscine_ev/yua_ev               @ 5990765c7873140813047f7e20622722d47f5268
piscine_ev/yuyigit_ev           @ 8ec47aedaa62b1969546f8854c41e8009c807323
push_swap_nikita_ev             @ 7d28175b903d025b734bfb26537f44fb4b4441b3
```

## Need Help?

If you're the repository owner and need help recovering the submodule URLs:
1. Check your local clone if you have one - it may have the `.gitmodules` file
2. Check any backups or other clones of this repository
3. Search for the original repositories on GitHub/GitLab using the commit SHAs
4. Contact the original contributors of these projects

## Git Submodules Quick Reference

For those new to git submodules:

- **List submodules**: `git submodule status`
- **Initialize submodules**: `git submodule init` (requires .gitmodules)
- **Update submodules**: `git submodule update --init --recursive`
- **Add a submodule**: `git submodule add <url> <path>`

## Contributing

If you have information about the original source repositories for these submodules, please open an issue or submit a pull request with the correct `.gitmodules` file.
