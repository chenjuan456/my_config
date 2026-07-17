# My Configuration Files (my-config)

This is a personal configuration repository containing configuration schemes for various terminal tools and development environments.

## Directory Structure

### fastfetch
Configuration for system information display tool
- **ascii.txt**: ASCII art characters displayed in the terminal
- **config.json**: Display configuration for fastfetch

### starship
Cross-platform command-line prompt configuration
- **starship.toml**: Starship prompt theme and style settings

### windows
Configuration under Windows system
- **gvim/vimrc.txt**: GVim editor configuration
- **vscode/**:
  - **keybindings.json**: VSCode keyboard shortcut bindings
  - **setting.json**: VSCode editor settings
  - **vscode-extensions.txt**: List of recommended VSCode extensions to install

### wsl
Configuration under WSL (Windows Subsystem for Linux) environment
- **vimrc.txt**: Vim editor configuration
- **yazi/**:
  - **keymap.toml**: Yazi file manager keymap configuration
  - **theme.toml**: Yazi file manager theme configuration
- **zshrc.txt**: Zsh shell configuration

## Usage Instructions

Select the corresponding configuration files according to your needs and copy them to the respective system paths:

```bash
# Example: Apply starship configuration
cp starship/starship.toml ~/.config/starship.toml

# Example: Apply WSL zsh configuration
cp wsl/zshrc.txt ~/.zshrc

# Example: Apply VSCode configuration
cp windows/vscode/setting.json ~/AppData/Roaming/Code/User/settings.json
```

## Tool Dependencies

- [fastfetch](https://github.com/fastfetch-cli/fastfetch) - Lightweight system information retrieval tool
- [starship](https://starship.rs/) - Cross-platform command-line prompt
- [Yazi](https://github.com/sxyazi/yazi) - Terminal file manager written in Rust
- Vim/gvim - Text editor
- VSCode - Cross-platform code editor
- Zsh - Z shell

## License

The configuration files in this repository are for personal use and learning/exchange only.