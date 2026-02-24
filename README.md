# my-shell-config

This repo contains all the files to set up my personal shell config, managed via [chezmoi](https://www.chezmoi.io/).

## Prerequisites

- Linux system (these templates are tailored for Linux)
- `git`
- `chezmoi` installed (see chezmoi docs for your distro)

## New setup (fresh machine)

1. Clone and initialize chezmoi with this repo:
	```bash
	chezmoi init git@github.com:YOUR_USERNAME/my-shell-config.git
	```

2. Review what chezmoi will apply:
	```bash
	chezmoi diff
	```

3. Apply the dotfiles to your home directory:
	```bash
	chezmoi apply
	```

4. Run the shell tools installer (installed by chezmoi as `~/install_shell_tools.sh`):
	```bash
	~/install_shell_tools.sh
	```

	This will install and configure:
	- `zsh`
	- `git`
	- `fzf` + `fzf-git.sh`
	- `starship`
	- `eza`
	- `zoxide`
	- `nnn` with plugins (`preview-tui`, `finder`, `fzcd`, `fzhist`), icons, starship-aligned colors, and `cd on quit` integration

5. Start a new shell (or log out and back in) to pick up the new configuration.

## Update existing setup

When you change these dotfiles or pull updates from the remote repo, re-apply them with chezmoi:

1. Pull latest changes from the remote:
	```bash
	cd ~/.config/chezmoi
	git pull
	```

2. Check what will change in your home directory:
	```bash
	chezmoi diff
	```

3. Apply the updates:
	```bash
	chezmoi apply
	```

4. If the installer script was updated (e.g. new tools added), re-run it:
	```bash
	~/install_shell_tools.sh
	```

5. Restart your shell to ensure all changes take effect.

## Notes

- The main install logic for shell tools lives in `dotfiles/run_onchange_install-packages.sh.tmpl` and is rendered to `~/install_shell_tools.sh` by chezmoi.
- Bash configuration is in `dotfiles/dot_bashrc.tmpl`.
- Zsh configuration is in `dotfiles/dot_zshrc.tmpl`.

Adjust paths, repo URL, and commands above if your setup differs.
