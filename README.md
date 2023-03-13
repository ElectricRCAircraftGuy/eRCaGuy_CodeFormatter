# eRCaGuy_CodeFormatter

A collection of scripts & configuration files to quickly and easily format your code (by calling `clang-format` or `git clang-format`, for instance)

By Gabriel Staples  
https://gabrielstaples.com  
www.ElectricRCAircraftGuy.com  


# Status
Done and works!

_I have a lot of this information/instructions [on Stack Overflow too, here](https://stackoverflow.com/a/56879394/4561887). See both sets of instructions--both this readme and that answer, in case one is more up-to-date or has more info. than the other._


# License
MIT  
See the "LICENSE" file.


# TODO
Newest on _top_.
1. [x] it could use some improvement, instructions, and workflow-design so I can get it easily imported as a submodule and figure out how to easily use it in all my other projects or whatever.


# References

1. Official `clang-format` documentation from the source code: https://github.com/llvm/llvm-project/blob/main/clang/docs/ClangFormat.rst
1. Source code for all of the clang compiler and tools from the llvm-project (includes `clang-format`): https://github.com/llvm/llvm-project
1. Releases: https://github.com/llvm/llvm-project/releases
    1. The latest pre-compiled `clang-format`, `clang-tidy`, etc., executables can always be extracted from the `bin` folder of the latest binary release. 
    1. Example: [**clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz**](https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz)
1. \*\*\*\*\* For my notes to myself on how to use git submodules, see: https://github.com/ElectricRCAircraftGuy/eRCaGuy_dotfiles#to-add-a-repo-as-a-submodule-inside-another-repo


# Installation, usage, & workflow

To easily use this tool to code format your own repo, do this:
```bash
# install clang-format
# - for Ubuntu 20 or later, do this:
sudo apt update
sudo apt install clang-format
# - for older versions of Ubuntu, see my instructions further below

# cd into your repo which you'd like to format; we are going to add this repo as a submodule into
# your repo
cd path/to/your/repo/you/want/to/format
# add my repo as a submodule into yours
git submodule add https://github.com/ElectricRCAircraftGuy/eRCaGuy_CodeFormatter.git
git commit

# Add necessary relative symlinks into the root of your repo, so that my tool will search from that
# level down
ln -sir eRCaGuy_CodeFormatter/run_clang-format.sh .
ln -sir ln -sir eRCaGuy_CodeFormatter/.clang-format .
# commit these symlinks to your repo
git add -A
git commit -m "Add symlinks to eRCaGuy_CodeFormatter clang-format tool"

# Run my tool by calling the symlink you just placed at the root of your repo!
# It will ask you if you'd like to format the files it finds. 
./run_clang-format.sh
# Commit the changes when it is done
git add -A
git commit -m "Run clang-format by calling './run_clang-format.sh'"

# To pull my latest upstream changes of eRCaGuy_CodeFormatter into your submodule in your repo
# - see my notes here: https://github.com/ElectricRCAircraftGuy/eRCaGuy_dotfiles#to-update-this-repo
git submodule update --init --recursive
git add -A
git commit -m "Update all subrepos to their latest upstream changes"
```


# General `clang-format` info

See also [my answer here](https://stackoverflow.com/a/56879394/4561887).


## 1. `clang-format`

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


## 2. `git clang-format`

The `git-clang-format` executable python script provided by LLVM, the makers of the `clang` C and C++ compiler and `clang-format`, easily auto-formats _just the lines of code you have changed_ in any git repo. Even though you _can_ run the script as `git-clang-format`, it is generally run as `git clang-format` (withOUT the dash after "git"), since `git` automatically recognizes any executable in your PATH which begins with `git-` as a git program extension. 

Here is my **recommended git workflow to call and use this `git clang-format` auto-formatter**:
```bash
# See what git changes you have
git difftool  
# OR: `git diff` if you haven't configured a difftool such as meld
git diff
# Add (stage) a C or C++ file to be committed
git add my_changed_file.c 

# Run `git-clang-format` to have `clang-format` check and
# auto-format **just your changed lines**. (This runs the
# `~/bin/git-clang-format` Python script).
git clang-format
# See what changes `clang-format` just made to your changed lines
git difftool
# OR
git diff

# Add (stage) this file again since it's been changed by
# `git-clang-format`
git add my_changed_file.c 
# commit the changed file
git commit
```

To install `meld` as your difftool, see my answer here: [How to use meld as your `git difftool` in place of `git diff`](https://stackoverflow.com/a/48979939/4561887).


<a id="installation-instructions"></a>
# `clang-format` Installation Instructions:

See also [my answer here](https://stackoverflow.com/a/56879394/4561887).


## To install on Ubuntu 20.04 or later:
```bash
sudo apt update
sudo apt install clang-format
```

However, for Ubuntu 18.04, this only gets you version (found by `clang-format --version`): `clang-format version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)`. This is too old, as it doesn't support many of the features I use in the `.clang-format` file here. So, install the latest version instead!


## To install the latest version of `clang-format` and `git-clang-format` (runnable as `git clang-format`):

As a convenience, I include a recent version of `clang-format` and `git-clang-format` in the [`bin` directory right here](bin).

Otherwise, to get the absolute latest, and to learn how to copy the executable into your PATH, follow these instructions:

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
    # make a ~/bin dir if it doesn't exist yet
    mkdir -p ~/bin
    # copy out `clang-format` into your ~/bin dir
    cp clang-format ~/bin
    # copy out `git-clang-format` into your ~/bin dir
    cp git-clang-format ~/bin
    
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
    # Otherwise, re-source your ~/.bashrc file:
    . ~/.bashrc

    # check your clang-format version to ensure it shows the version you just
    # installed
    clang-format --version
    # Ensure it is found in your ~/bin dir; my output to this command is:
    # `/home/gabriel/bin/clang-format`
    which clang-format
    # Check `git-clang-format` too
    which git-clang-format

    # Check the help menus
    clang-format -h
    git clang-format -h
    # OR (same thing as the line just above):
    git-clang-format -h

    # manually delete the the extracted folder if desired (to free up ~5 GB of
    # space), and the downloaded *.tar.xz file as well, if desired (to free up
    # ~600 MB of space)
    ```
