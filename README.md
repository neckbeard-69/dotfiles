 # My Dotfiles

 This repository contains my personal configuration files for the tools I use on my setup.

## Supported Operating Systems

These configurations are expected to work on any OS that supports the specified tools. However, I haven't tested them on Windows.

## How to Use These Dotfiles

I recommend using **GNU Stow** to manage the dotfiles. You can also copy them manually if you prefer, though this might be more tedious.

### Installing GNU Stow

1. **On Arch-based Distros**:
    ```bash
    sudo pacman -S stow
    ```

2. **On Debian-based Distros (Ubuntu, Pop!_OS, Mint, etc.)**:
    ```bash
    sudo apt install stow
    ```

3. **On macOS**:
   I recommend using Homebrew to install Stow.

    a. Install Homebrew:
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

   b. Then use Homebrew to install Stow:
   ```bash
   brew install stow
   ```

4. **On Windows**:
    Currently, there’s no direct support for GNU Stow on Windows. You might consider using [WSL (Windows Subsystem for Linux)](https://docs.microsoft.com/en-us/windows/wsl/) if you need a Unix-like environment.

**Note**: You can install Stow on any system using your package manager, even if it's not listed above.

### Using GNU Stow to Create Symlinks

First, clone the repository:

```bash
 git clone https://github.com/neckbeard-69/dotfiles.git
 cd dotfiles
 ```

If `git` is not installed, please install it by searching for instructions specific to your OS.

After installing the tool you want, navigate to the dotfiles directory and run the following command, replacing `nvim` with the name of the directory corresponding to the tool you want:

```bash
 stow nvim
 ```

As mentioned earlier, you can also copy the files manually, but be aware that you’ll need to know what to copy and where to copy it.
And you're all set
