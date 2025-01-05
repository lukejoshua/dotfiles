# Dotfile Installation

## Quickstart

Run the following command to download and initialise this repo on a new machine:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply lukejoshua
```

### Checks

- Run `nvim` and run a health check with `:LazyHealth`
- Check that `asdf`-managed tools have all been installed (e.g. `node`, `bun`)

## Overview

### [Chezmoi](https://chezmoi.io)

#### TODO

- automate editing/applying/pushing without breaking anything
- document installation process, removal of bin, scripts
- document workflow, gotchas

### Homebrew

- brew bundle
- configuration
- usage

#### TODO

- automate Homebrew maintenance tasks
- command wrapping
  - chezmoi-aware `brew install`
  - interactive installation (e.g. search)

### [Wezterm](https://wezfurlong.org/wezterm)

#### TODO

- simpler keybindings
- better session management
- more interesting background

### [`fish`](https://fishshell.com)

- config
- prompt
- util functions

### [Neovim](https://neovim.io)

- lazyvim
- plugins, overrides
- custom stuff

#### TODO

- get rid of unused plugins, if any
- better snippets

### [`asdf`](https://asdf-vm.com)

- installation method
- usage

#### TODO

- pin to a specific branch

### [Obsidian](https://obsidian.md)

#### TODO

- Sync
- Webclipper

### [Raycast](https://raycast.com)

Still learning how to use this, but these seem useful:

- [Browser Extension](https://www.raycast.com/browser-extension)

#### Extensions

- Spotify Player
- Arc
- Brew
- Slack
- Obsidian
- Github
- Pomodoro
- Google Search
- Emoji Search
- Coffee
- ChatGPT (?)


#### TODO

- Find out if this can be configured programatically

### Arc

#### TODO

- extensions (raycast, adblock, sponsorblock?)
- import spaces or sync?

### Utils

- `fzf`: fuzzy finder used in Neovim and scripts
- `jq`: `json` querying tool
- `tldr`: like `man`, but 1000x less text
- `eza`: better `ls`
- `ripgrep`: better `grep`
- `bat`: better `cat`
- `batman`: better `man`
- `fd`: better `find`
- `lazygit`: awesome Git interface
- `gh`: GitHub CLI

## TODO

- Find alternatives to [Homerow](homerow.app)
- Complete this README
- better documenation in scripts, config files
- automated healthchecks and cleanup tasks (on shell login?)
- ollama
