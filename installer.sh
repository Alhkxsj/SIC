#!/data/data/com.termux/files/usr/bin/bash
set -e

# 🌟 万能终端环境安装器 V3.0 | Author: 快手@啊泠好困想睡觉

echo -e "\n\033[1;35m╭──────────────────────────────────────────╮\033[0m"
echo -e "\033[1;35m│ 🌸 欢迎使用终端环境安装器 🌸           │\033[0m"
echo -e "\033[1;35m╰──────────────────────────────────────────╯\033[0m"
echo -e "\033[1;36mGitHub: https://github.com/Alhkxsj\033[0m\n"

# 清华源切换提示
echo -ne "\033[1;36m是否切换为清华镜像源以加速安装？(y/n): \033[0m"
read -r change_mirror
if [[ "$change_mirror" =~ ^[Yy]$ ]]; then
  echo -e "\033[1;34m正在切换为清华源...\033[0m"
  cat > "$PREFIX/etc/apt/sources.list" <<EOF
deb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main
EOF
  apt update -y
  echo -e "\033[1;32m✔ 已切换为清华源\033[0m"
fi

# 超全情感语录（安装过程及安装后显示）
HEART_QUOTES=(
  "『其实…我只是不想你把我忘了。』"
  "『你在群里说话，我却再也插不上话。』"
  "『我们真的…回不去了吗？』"
  "『小学最重要的朋友，怎么就成了路人？』"
  "『我是故意的，因为我想让你注意我。』"
  "『他从来没说错什么，是我太玻璃心了吧。』"
  "『那个我最喜欢的人，却最轻易地把我删了。』"
  "『你只用几秒绝交，我却记了几年。』"
  "『我也想忘掉你，可是我连梦里都是你。』"
  "『范思瑶从未走远，她只是安静在角落。』"
  "『没事的，我习惯了，不重要。』"
  "『你以为我无所谓，其实我每晚都想你。』"
  "『你不记得的日子，我一直记着。』"
  "『不回我消息，也是一种回答吧。』"
  "『再热烈的喜欢，被冷漠几次也会熄灭。』"
  "『后来啊，我连你头像都不敢点开了。』"
  "『曾经每天聊天的人，现在成了陌生人。』"
  "『明知道是梦，还是希望别醒来。』"
  "『你转身之后，我才开始崩溃。』"
  "『有些对不起，只能在梦里说。』"
  "『我记得你所有的笑，却忘不掉那句“算了”。』"
  "『我装作不在意，其实心都碎了。』"
  "『为什么最温柔的人，总是最先放手？』"
  "『那年夏天的约定，现在还算数吗？』"
  "『我只是在等一个不会来的回复。』"
  "『你走的那天，我整个世界都静了。』"
  "『我不想告别，但你早就走了。』"
  "『我为你删掉了所有聊天记录，却留着截图。』"
  "『也许我们…本不该认识。』"
)

WAIT_QUOTES=(
  "📦 程序准备中，请稍等..."
  "⌛ 正在处理安装流程，请耐心等待..."
  "🛠️ 安装即将完成，感谢你的耐心。"
  "📡 正在连接服务器，稍后将继续安装..."
  "🔄 稍微等待一下，数据同步中..."
  "⏳ 当前操作需要几秒钟，请不要关闭窗口。"
  "🔧 软件包正在配置中，请稍候..."
  "🌸 安装即将完成，世界正在变得柔软…"
  "🩰 程序还没跑完呢，不如喝口水？"
  "🦋 代码在跳舞，请勿打扰她的节奏♪"
  "🌙 星星那么远，也值得等待，不是吗？"
  "📥 一切正在准备中，请安心等待。"
)

random_heart_quote() {
  local quote="${HEART_QUOTES[$RANDOM % ${#HEART_QUOTES[@]}]}"
  local color=$((31 + RANDOM % 6))
  echo -e "\n\033[1;${color}m$quote\033[0m\n"
}

random_wait_quote() {
  echo -e "\n\033[1;34m${WAIT_QUOTES[$RANDOM % ${#WAIT_QUOTES[@]}]}\033[0m"
}

show_progress() {
  local i
  for ((i = 0; i <= 100; i += 10)); do
    echo -ne "\r\033[1;35m安装进度：[$(printf '%-*s' $((i/10)) '#' | tr ' ' '#')$(printf '%-*s' $((10 - i/10)) ' ')] $i%%\033[0m"
    sleep 0.1
  done
  echo
}

install_package() {
  local pkg=$1
  # 先检测命令或二进制是否已存在，避免重复安装
  if command -v "$pkg" >/dev/null 2>&1 || [ -e "$PREFIX/bin/$pkg" ]; then
    echo -e "\033[1;90m略过（已安装）：$pkg\033[0m"
  else
    random_wait_quote
    echo -e "\033[1;36m➤ 正在安装：$pkg\033[0m"
    if pkg install -y "$pkg" > /dev/null 2>&1; then
      show_progress
      echo -e "\033[1;32m✔ 安装成功：$pkg\033[0m"
      random_heart_quote
    else
      echo -e "\033[1;31m✘ 安装失败：$pkg\033[0m"
    fi
    echo -e "\033[1;90m--------------------------------------\033[0m"
  fi
}

select_group() {
  local name="$1"
  shift
  local -a packages=("$@")
  echo -ne "\n\033[1;36m是否安装 ${name}？(y/n): \033[0m"
  read -r ans
  if [[ "$ans" =~ ^[Yy]$ ]]; then
    echo -e "\033[1;34m📥 正在安装 ${name}...\033[0m"
    for pkg in "${packages[@]}"; do
      install_package "$pkg"
    done
  else
    echo -e "\033[1;90m跳过 ${name}\033[0m"
  fi
}

# 超全软件包列表

core_packages=(
abseil-cpp android-tools apt apt-file attr bash bat bison blk-utils boost brotli busybox bzip2 c-ares ca-certificates ca-certificates-java clang clvk cmake cmatrix command-not-found coreutils cowsay cups curl dash debianutils dialog diffutils docker dos2unix double-conversion dpkg dpkg-perl dpkg-scanpackages ed emacs exiftool eza fakeroot fastfetch figlet file findutils flac flex fontconfig fortune freetype fribidi gawk gdbm gettext gnupg go-findimagedupes gpgv grep gzip harfbuzz iconv id3lib id3v2 inetutils jsoncpp krb5 lazygit ldns leptonica less libandroid-execinfo libandroid-glob libandroid-posix-semaphore libandroid-selinux libandroid-shmem libandroid-spawn libandroid-stub libandroid-support libandroid-utimes libandroid-wordexp libaom libapt-pkg-perl libarchive libassuan libblkid libbz2 libc++ libc++utilities libcaca libcairo libcap-ng libcompiler-rt libcrypt libcurl libdav1d libdb libde265 libdevmapper libdrm libedit libepoxy libevent libexpat libffi libflac libfontenc libgcrypt libgit2 libglvnd libgmp libgnutls libgpg-error
)

x11_packages=(
adwaita-icon-theme-legacy adwaita-icon-theme angle-android appstream gdk-pixbuf gnome-font-viewer gnome-themes-extra gtk-update-icon-cache gtk4 hicolor-icon-theme imlib2 iso-codes kf6-kwindowsystem kvantum libadwaita libgdk-pixbuf libgtk-4 libgtk-update-icon-cache libiconv libx11 libxext libxrandr libxrender
)

media_packages=(
flac id3lib id3v2 exiftool giflib libflac libde265 ffmpeg mpv imagemagick sox
)

container_packages=(
containerd docker fakeroot proot proot-distro pulseaudio
)

other_tools=(
lazygit figlet cowsay fastfetch eza aria2 neofetch toilet lolcat ncurses-utils nano micro tree termux-api termux-tools termux-exec termux-elf-cleaner termux-am termux-keyring termux-services termux-x11
)

# 安装流程
select_group "核心基础工具包" "${core_packages[@]}"
select_group "图形界面 X11 支持包" "${x11_packages[@]}"
select_group "多媒体支持包" "${media_packages[@]}"
select_group "容器与虚拟化支持包" "${container_packages[@]}"
select_group "其他终端美化与实用工具" "${other_tools[@]}"

# 尾声寄语
echo -e "\n\033[1;35m🎉 所有选中软件包安装完成 🎉\033[0m"

echo -e "\n\033[1;36m— 作者寄语 —\033[0m"
echo -e "\033[1;37m其实我还忘不掉那个人，但我已经不知道怎么面对她了，现在我也有对象了。\033[0m"

echo -e "\n\033[1;36m— 原创诗《范思瑶》 —\033[0m"
echo -e "\033[1;35m繁花落，思成各，思君朝暮化烟络，瑶台雪空灼。
情难收，怨难收，三秋一别覆水舟，碎琼满西楼。
玉不琢，人不诺，不悔真心错付昨。
簪不合，泪成河，不念旧诺自沉疴。
镜不映，影伶仃，不照人间共白头。\033[0m"

echo -e "\n\033[1;32m🌸 致终端中的你：Forever in Memory 🌸\033[0m\n"#!/data/data/com.termux/files/usr/bin/bash
set -e

# 🌟 万能终端环境安装器 V3.0 | Author: 快手@啊泠好困想睡觉

echo -e "\n\033[1;35m╭──────────────────────────────────────────╮\033[0m"
echo -e "\033[1;35m│ 🌸 欢迎使用终端环境安装器 🌸           │\033[0m"
echo -e "\033[1;35m╰──────────────────────────────────────────╯\033[0m"
echo -e "\033[1;36mGitHub: https://github.com/Alhkxsj\033[0m\n"

# 清华源切换提示
echo -ne "\033[1;36m是否切换为清华镜像源以加速安装？(y/n): \033[0m"
read -r change_mirror
if [[ "$change_mirror" =~ ^[Yy]$ ]]; then
  echo -e "\033[1;34m正在切换为清华源...\033[0m"
  cat > "$PREFIX/etc/apt/sources.list" <<EOF
deb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main
EOF
  apt update -y
  echo -e "\033[1;32m✔ 已切换为清华源\033[0m"
fi

# 超全情感语录（安装过程及安装后显示）
HEART_QUOTES=(
  "『其实…我只是不想你把我忘了。』"
  "『你在群里说话，我却再也插不上话。』"
  "『我们真的…回不去了吗？』"
  "『小学最重要的朋友，怎么就成了路人？』"
  "『我是故意的，因为我想让你注意我。』"
  "『他从来没说错什么，是我太玻璃心了吧。』"
  "『那个我最喜欢的人，却最轻易地把我删了。』"
  "『你只用几秒绝交，我却记了几年。』"
  "『我也想忘掉你，可是我连梦里都是你。』"
  "『范思瑶从未走远，她只是安静在角落。』"
  "『没事的，我习惯了，不重要。』"
  "『你以为我无所谓，其实我每晚都想你。』"
  "『你不记得的日子，我一直记着。』"
  "『不回我消息，也是一种回答吧。』"
  "『再热烈的喜欢，被冷漠几次也会熄灭。』"
  "『后来啊，我连你头像都不敢点开了。』"
  "『曾经每天聊天的人，现在成了陌生人。』"
  "『明知道是梦，还是希望别醒来。』"
  "『你转身之后，我才开始崩溃。』"
  "『有些对不起，只能在梦里说。』"
  "『我记得你所有的笑，却忘不掉那句“算了”。』"
  "『我装作不在意，其实心都碎了。』"
  "『为什么最温柔的人，总是最先放手？』"
  "『那年夏天的约定，现在还算数吗？』"
  "『我只是在等一个不会来的回复。』"
  "『你走的那天，我整个世界都静了。』"
  "『我不想告别，但你早就走了。』"
  "『我为你删掉了所有聊天记录，却留着截图。』"
  "『也许我们…本不该认识。』"
)

WAIT_QUOTES=(
  "📦 程序准备中，请稍等..."
  "⌛ 正在处理安装流程，请耐心等待..."
  "🛠️ 安装即将完成，感谢你的耐心。"
  "📡 正在连接服务器，稍后将继续安装..."
  "🔄 稍微等待一下，数据同步中..."
  "⏳ 当前操作需要几秒钟，请不要关闭窗口。"
  "🔧 软件包正在配置中，请稍候..."
  "🌸 安装即将完成，世界正在变得柔软…"
  "🩰 程序还没跑完呢，不如喝口水？"
  "🦋 代码在跳舞，请勿打扰她的节奏♪"
  "🌙 星星那么远，也值得等待，不是吗？"
  "📥 一切正在准备中，请安心等待。"
)

random_heart_quote() {
  local quote="${HEART_QUOTES[$RANDOM % ${#HEART_QUOTES[@]}]}"
  local color=$((31 + RANDOM % 6))
  echo -e "\n\033[1;${color}m$quote\033[0m\n"
}

random_wait_quote() {
  echo -e "\n\033[1;34m${WAIT_QUOTES[$RANDOM % ${#WAIT_QUOTES[@]}]}\033[0m"
}

show_progress() {
  local i
  for ((i = 0; i <= 100; i += 10)); do
    echo -ne "\r\033[1;35m安装进度：[$(printf '%-*s' $((i/10)) '#' | tr ' ' '#')$(printf '%-*s' $((10 - i/10)) ' ')] $i%%\033[0m"
    sleep 0.1
  done
  echo
}

install_package() {
  local pkg=$1
  # 先检测命令或二进制是否已存在，避免重复安装
  if command -v "$pkg" >/dev/null 2>&1 || [ -e "$PREFIX/bin/$pkg" ]; then
    echo -e "\033[1;90m略过（已安装）：$pkg\033[0m"
  else
    random_wait_quote
    echo -e "\033[1;36m➤ 正在安装：$pkg\033[0m"
    if pkg install -y "$pkg" > /dev/null 2>&1; then
      show_progress
      echo -e "\033[1;32m✔ 安装成功：$pkg\033[0m"
      random_heart_quote
    else
      echo -e "\033[1;31m✘ 安装失败：$pkg\033[0m"
    fi
    echo -e "\033[1;90m--------------------------------------\033[0m"
  fi
}

select_group() {
  local name="$1"
  shift
  local -a packages=("$@")
  echo -ne "\n\033[1;36m是否安装 ${name}？(y/n): \033[0m"
  read -r ans
  if [[ "$ans" =~ ^[Yy]$ ]]; then
    echo -e "\033[1;34m📥 正在安装 ${name}...\033[0m"
    for pkg in "${packages[@]}"; do
      install_package "$pkg"
    done
  else
    echo -e "\033[1;90m跳过 ${name}\033[0m"
  fi
}

# 超全软件包列表

core_packages=(
abseil-cpp android-tools apt apt-file attr bash bat bison blk-utils boost brotli busybox bzip2 c-ares ca-certificates ca-certificates-java clang clvk cmake cmatrix command-not-found coreutils cowsay cups curl dash debianutils dialog diffutils docker dos2unix double-conversion dpkg dpkg-perl dpkg-scanpackages ed emacs exiftool eza fakeroot fastfetch figlet file findutils flac flex fontconfig fortune freetype fribidi gawk gdbm gettext gnupg go-findimagedupes gpgv grep gzip harfbuzz iconv id3lib id3v2 inetutils jsoncpp krb5 lazygit ldns leptonica less libandroid-execinfo libandroid-glob libandroid-posix-semaphore libandroid-selinux libandroid-shmem libandroid-spawn libandroid-stub libandroid-support libandroid-utimes libandroid-wordexp libaom libapt-pkg-perl libarchive libassuan libblkid libbz2 libc++ libc++utilities libcaca libcairo libcap-ng libcompiler-rt libcrypt libcurl libdav1d libdb libde265 libdevmapper libdrm libedit libepoxy libevent libexpat libffi libflac libfontenc libgcrypt libgit2 libglvnd libgmp libgnutls libgpg-error
)

x11_packages=(
adwaita-icon-theme-legacy adwaita-icon-theme angle-android appstream gdk-pixbuf gnome-font-viewer gnome-themes-extra gtk-update-icon-cache gtk4 hicolor-icon-theme imlib2 iso-codes kf6-kwindowsystem kvantum libadwaita libgdk-pixbuf libgtk-4 libgtk-update-icon-cache libiconv libx11 libxext libxrandr libxrender
)

media_packages=(
flac id3lib id3v2 exiftool giflib libflac libde265 ffmpeg mpv imagemagick sox
)

container_packages=(
containerd docker fakeroot proot proot-distro pulseaudio
)

other_tools=(
lazygit figlet cowsay fastfetch eza aria2 neofetch toilet lolcat ncurses-utils nano micro tree termux-api termux-tools termux-exec termux-elf-cleaner termux-am termux-keyring termux-services termux-x11
)

# 安装流程
select_group "核心基础工具包" "${core_packages[@]}"
select_group "图形界面 X11 支持包" "${x11_packages[@]}"
select_group "多媒体支持包" "${media_packages[@]}"
select_group "容器与虚拟化支持包" "${container_packages[@]}"
select_group "其他终端美化与实用工具" "${other_tools[@]}"

# 尾声寄语
echo -e "\n\033[1;35m🎉 所有选中软件包安装完成 🎉\033[0m"

echo -e "\n\033[1;36m— 作者寄语 —\033[0m"
echo -e "\033[1;37m其实我还忘不掉那个人，每当在校园相遇，不知如何面对，只好匆匆而过。\033[0m"

echo -e "\n\033[1;36m— 原创诗《范思瑶》 —\033[0m"
echo -e "\033[1;35m繁花落，思成各，思君朝暮化烟络，瑶台雪空灼。
情难收，怨难收，三秋一别覆水舟，碎琼满西楼。
玉不琢，人不诺，不悔真心错付昨。
簪不合，泪成河，不念旧诺自沉疴。
镜不映，影伶仃，不照人间共白头。\033[0m"

echo -e "\n\033[1;32m🌸 致终端中的你：Forever in Memory 🌸\033[0m\n"
