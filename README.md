# My dotfiles

dotfiles shit

## Requirements

Ensure you have the following installed on your system

### Git

```
pacman -S Git
```

### Stow

```
pacman -S stow
```

## Installation

First, checkout the dotfiles repo in your $HOME dir using Git

```
clone the repo
cd dotfiles
```

then use stow

```
stow .
```
Also build the fzf native nvim plugin by

```
cd ~/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim
```
then

```
cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
```
