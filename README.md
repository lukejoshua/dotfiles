# Dotfile Installation

## Quickstart

Run the following command to download this repo and symlink it appropriately
with [Chezmoi](https://www.chezmoi.io/).

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply lukejoshua
```

### Checks

- Run `nvim` and run a health check with `:LazyHealth`
- Check that `asdf`-managed tools have all been installed (e.g. `node`, `bun`, `java`)

## Overview

### Chezmoi

- installation process, removal of bin, scripts
- usage

#### TODO

- automate editing/applying/pushing without breaking anything

### Homebrew

- brew bundle
- configuration
- usage

#### TODO

- automate Homebrew maintenance tasks
- command wrapping
  - chezmoi-aware `brew install`
  - interactive installation (e.g. search)

### Wezterm

#### TODO

- simpler keybindings
- better session management
- more interesting background

### Fish

- config
- prompt
- util functions

### Neovim

- lazyvim
- plugins, overrides
- custom stuff

#### TODO

- get rid of unused plugins, if any
- better snippets

### `asdf`

- installation method
- usage

#### TODO

- pin to a specific branch

### Obsidian

### MacOS-specific

- Homerow 
- Raycast

### Utils

- `fzf`: fuzzy finder used in Neovim and scripts
- `eza`: better `ls`
- `bat`: better `cat`
- `batman`: better `man`

### Browsers

- Arc
    - extensions (raycast, adblock, sponsorblock?)
    - import spaces or sync?

### Misc

- Mockoon

## TODO

- Complete this README
- better documenation in scripts, config files
- automated healthchecks and cleanup tasks (on shell login?)
- ollama
