#!/data/data/com.termux/files/usr/bin/bash
set -e

echo -e "\033[1;35m🌸 正在下载终端环境安装器脚本... 请稍候\033[0m"

INSTALLER_URL="https://raw.githubusercontent.com/Alhkxsj/termux-installer/main/full-installer.sh"
TARGET_SCRIPT="$HOME/终端环境安装器.sh"

curl -Lo "$TARGET_SCRIPT" "$INSTALLER_URL"

chmod +x "$TARGET_SCRIPT"

echo -e "\n\033[1;32m✔ 下载完成，正在运行...\033[0m"
bash "$TARGET_SCRIPT"
