#!/usr/bin/env bash

## Welcome to WineLike!
## This is no more than a Wine wrapper that:
## - Installs patched Wine optimized for gaming/common usage
## - Creates a WinePrefix containing all the most needed utils for anything to work (vcrun, dotnet, dxvk, corefonts..) + native file manager support
## - Creates a desktop entry to directly launch your .exe files as if you were on Windows, but optimized with ESYNC and FSYNC!
## - Remember that this needs Wine dependencies to be already installed: https://github.com/lutris/docs/blob/master/WineDependencies.md

function Echo(){
    echo -e '\033[1;32m'"WineLike:\033[0m $*"
}

function Install(){

    prereqs=("tar" "wget")
    for p in "${prereqs[@]}"; do
        if ! command -v "$p" &> /dev/null; then
            Echo "$p not found; please install it or the script will fail!"
            exit 1
        fi
    done

    Echo "Downloading Wine-TKG.."
    WINELINK="https://github.com/Kron4ek/Wine-Builds/releases/download/9.1/wine-9.1-staging-tkg-amd64.tar.xz"
    mkdir -p ~/.local/share/winelike
    wget -O /tmp/wine-tkg.tar.xz $WINELINK
    tar -xf /tmp/wine-tkg.tar.xz -C ~/.local/share/winelike
    mv ~/.local/share/winelike/wine-9.1-staging-tkg-amd64 ~/.local/share/winelike/wine-tkg


    Echo "Creating WinePrefix with needed components (might take a while!).."
    WINETRICKSLINK="https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
    wget -O ~/.local/share/winelike/winetrickswl $WINETRICKSLINK && chmod +x ~/.local/share/winelike/winetrickswl
    export PATH=/home/$USER/.local/share/winelike/wine-tkg/bin:$PATH

    if [ -d ~/.WineLike ]; then
        Echo "WineLike prefix exists, skipping.."
    else
        WINEARCH=win64 WINEPREFIX=~/.WineLike ~/.local/share/winelike/winetrickswl -q -f dotnet48 cjkfonts corefonts vcrun2022 dxvk vkd3d
        WINEPREFIX=~/.WineLike wine reg add "HKEY_CLASSES_ROOT\folder\shell\open\command"
        WINEPREFIX=~/.WineLike wine reg delete "HKEY_CLASSES_ROOT\folder\shell\open\ddeexec" /f
        WINEPREFIX=~/.WineLike wine reg add "HKEY_CLASSES_ROOT\folder\shell\open\command" /f /ve /t REG_SZ /d "/home/$USER/.local/share/winelike/nativefolder.sh xdg-open \"%1\""
        Echo "WineLike prefix installation done.."
    fi


    Echo "Creating desktop entry.."
    mkdir -p ~/.local/share/applications
    echo "[Desktop Entry]
    Type=Application
    Name=WineLike
    MimeType=application/x-ms-dos-executable;
    Exec=env WINEESYNC=1 WINEFSYNC=1 WINEPREFIX=/home/$USER/.WineLike /home/$USER/.local/share/winelike/wine-tkg/bin/wine %f
    NoDisplay=true
    StartupNotify=true
    Icon=wine" | tee "$HOME/.local/share/applications/WineLike.desktop" > /dev/null
    chmod +x "$HOME/.local/share/applications/WineLike.desktop"


    Echo "Installing WineLike helper scripts.."
    wget -O /home/$USER/.local/share/winelike/nativefolder.sh https://raw.githubusercontent.com/NelloKudo/WineLike/main/misc/nativefolder.sh && chmod +x /home/$USER/.local/share/winelike/nativefolder.sh
    wget -O /tmp/winelike https://raw.githubusercontent.com/NelloKudo/WineLike/main/winelike.sh && chmod +x /tmp/winelike
    Echo "Copying to /usr/local/bin.."
    sudo mv /tmp/winelike /usr/local/bin

    Echo "WineLike is now installed! Start by right-clicking your"
    Echo "exe files and selecting 'Open with WineLike..' e.e"
}


case $1 in
    '')
    Install
    ;;

    '--help')
    Echo "Welcome to WineLike!"
    Echo "Install it using ./winelike-install.sh"
    Echo "After installing, use 'winelike' for the helper script."
    Echo "Make sure you followed the steps at README!"
esac