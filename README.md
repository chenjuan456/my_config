

# 我的配置文件 (my-config)

这是一个个人配置文件仓库，包含了多种终端工具、开发环境的配置方案。

## 目录结构

### fastfetch
系统信息展示工具的配置
- **ascii.txt**: 终端显示的 ASCII 艺术字符
- **config.json**: 快速获取 (fastfetch) 的显示配置

### starship
跨平台命令行提示符配置
- **starship.toml**: Starship 提示符主题和样式设置

### windows
Windows 系统下的配置
- **gvim/vimrc.txt**: GVim 编辑器配置
- **vscode/**:
  - **keybindings.json**: VSCode 键盘快捷键绑定
  - **setting.json**: VSCode 编辑器设置
  - **vscode-extensions.txt**: 推荐安装的 VSCode 扩展列表

### wsl
WSL (Windows Subsystem for Linux) 环境下的配置
- **vimrc.txt**: Vim 编辑器配置
- **yazi/**:
  - **keymap.toml**: Yazi 文件管理器的快捷键配置
  - **theme.toml**: Yazi 文件管理器主题配置
- **zshrc.txt**: Zsh shell 配置

## 使用方法

根据需要选择对应的配置文件，复制到相应的系统路径：

```bash
# 示例：应用 starship 配置
cp starship/starship.toml ~/.config/starship.toml

# 示例：应用 WSL zsh 配置
cp wsl/zshrc.txt ~/.zshrc

# 示例：应用 VSCode 配置
cp windows/vscode/setting.json ~/AppData/Roaming/Code/User/settings.json
```

## 工具依赖

- [fastfetch](https://github.com/fastfetch-cli/fastfetch) - 轻量级系统信息获取工具
- [starship](https://starship.rs/) - 跨平台命令行提示符
- [Yazi](https://github.com/sxyazi/yazi) - Rust 编写的终端文件管理器
- Vim/gvim - 文本编辑器
- VSCode - 跨平台代码编辑器
- Zsh - Z shell

## 许可证

本仓库中的配置文件仅供个人使用和学习交流。