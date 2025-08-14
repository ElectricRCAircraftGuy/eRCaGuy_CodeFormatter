This file is part of eRCaGuy_CodeFormatter: https://github.com/ElectricRCAircraftGuy/eRCaGuy_CodeFormatter

1. `clang-format` is the binary executable extracted from the `bin` folder of a given release, here: https://github.com/llvm/llvm-project/releases.
1. `git-clang-format` comes from there too.


## Quick start

Run this to obtain the original, large files after cloning the repo: 
```bash
# Recombine split files within the directory of the `recombine_files.sh` script itself,
# and downwards
# - This searches for files named 'filename.partaa', etc., and recombines all parts into one. 
./recombine_files.sh
```


## Committing large files to GitHub

GitHub warns if you commit files > 50 MiB, and blocks files larger than 100 MiB. So, run the following. 

_**WARNING**_: The `split_large_files.sh` script splits files from the location of that script, recursively, and downwards. Do NOT copy the script nor move it into any dir under which you do not want it to split files! Ex: if you moved it to your root dir, it would find and split **all large files on your entire system**, which is certainly not what you want!

```bash
# Split all large files within the directory of the `split_large_files.sh` script itself, 
# and downwards. 
# - This creates files named 'filename.partaa', 'filename.partab', etc.
# - ===> SEE WARNING JUST ABOVE! <===
./split_large_files.sh

# Recombine split files within the directory of the `recombine_files.sh` script itself,
# and downwards
# - This searches for files named 'filename.partaa', etc., and recombines all parts into one. 
./recombine_files.sh
```

Now, you can update your `.gitignore` to ignore the large file, and commit the smaller parts instead!


## Specific releases

1. Main release page: https://github.com/llvm/llvm-project/releases
1. 14.0.0: https://github.com/llvm/llvm-project/releases/tag/llvmorg-14.0.0
1. 20.1.8 [the most current as of 13 Aug. 2025]: https://github.com/llvm/llvm-project/releases/tag/llvmorg-20.1.8

