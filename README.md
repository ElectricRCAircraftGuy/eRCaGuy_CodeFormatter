# eRCaGuy_CodeFormatter

A collection of scripts & configuration files to quickly and easily format your code (by calling clang-format, for instance)

By Gabriel Staples  
https://gabrielstaples.com  
www.ElectricRCAircraftGuy.com  


# Status
Works, but could use some improvement, instructions, and workflow-design so I can get it easily imported as a submodule and figure out how to easily use it in all my other projects or whatever.


# License
MIT


# References

1. Official `clang-format` documentation from the source code: https://github.com/llvm/llvm-project/blob/main/clang/docs/ClangFormat.rst
1. Source code for all of the clang compiler and tools from the llvm-project (includes `clang-format`): https://github.com/llvm/llvm-project
1. Releases: https://github.com/llvm/llvm-project/releases
    1. The latest pre-compiled `clang-format`, `clang-tidy`, etc., executables can always be extracted from the `bin` folder of the latest binary release. 
    1. Example: [**clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz**](https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz)


# Usage

1. Option 1: to auto-format ALL C and C++ files at the path of `run_clang-format.sh` and below:
    ```bash
    cd path/to/here
    ./run_clang-format.sh
    ```
1. Option 2: to auto-format just a specific file or two:
    ```bash
    # Format this file in-place (`-i`)
    clang-format --verbose -i --style=file "path/to/file1.h" "path/to/file2.c"
    ```
1. The way that `--style=file` works is it tells `clang-format` to look for and use the nearest `.clang-format` file, either in the current directory, or in a parent directory. It will scan the current directory for a `.clang-format` file, and if none is found, it will `cd ..` to move up one directory, then it will scan again, and so-on, until it either scans all the way to the root dir at `/`, OR until it finds a `.clang-format` file, whichever happens first. In this way, you can place a `.clang-format` file in your `$HOME` dir as a sort of "main settings file", and you can make more-specific copies of the `clang-format` file in any lower directory, as needed, to customize the format settings for a _specific directory_ or _project_ you may be working on.


<a id="installation-instructions"></a>
# `clang-format` Installation Instructions:


## To install on Ubuntu 20.04 or later:
```bash
sudo apt update
sudo apt install clang-format
```

However, for Ubuntu 18.04, this only gets you version (found by `clang-format --version`): `clang-format version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)`. This is too old, as it doesn't support many of the features I use in the `.clang-format` file here. So, install the latest version instead!


## To install the latest version of `clang-format`:

1. Go to the releases page: https://github.com/llvm/llvm-project/releases
1. Find the latest binary release for your operating system. Example: for 64-bit Linux, it is currently (as of Mar. 2022): **clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz**. The download link is: https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
1. Use the link you found above for the next commands:
    ```bash
    url="https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz"
    # download it; be patient: the file is ~600 MB
    wget "$url"
    # extract it; be patient: this could take several minutes, as the file is
    # about 5 GB when extracted! On my high-speed computer with SSD, it took
    # ~1 minute
    time tar xf clang+llvm*.tar.xz
    # cd into the bin dir
    cd clang+llvm*/bin
    # copy out `clang-format` into your ~/bin dir
    mkdir -p ~/bin
    cp clang-format ~/bin
    
    # Manually edit your ~/.profile file to ensure it contains the following in
    # order to ensure ~/bin is part of your executable PATH variable. This is
    # part of your default Ubuntu ~/.profile file (for which you have a backup
    # copy in /etc/skel/.profile):
    #
    #       # set PATH so it includes user's private bin if it exists
    #       if [ -d "$HOME/bin" ] ; then
    #           PATH="$HOME/bin:$PATH"
    #       fi

    # Now, if this is your first time creating and using the ~/bin dir, log out
    # of Ubuntu and log back in. 

    # check your clang-format version to ensure it shows the version you just
    # installed
    clang-format --version
    # Ensure it is found in your ~/bin dir; my output to this command is:
    # `/home/gabriel/bin/clang-format`
    which clang-format

    # manually delete the the extracted folder if desired, and the
    # downloaded *.tar.xz file as well, if desired
    ```
