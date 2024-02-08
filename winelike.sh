#!/usr/bin/env bash

## Welcome to WineLike Script Helper!
## - Repo link: https://github.com/NelloKudo/WineLike
## - Remember that this needs Wine dependencies to be already installed: https://github.com/lutris/docs/blob/master/WineDependencies.md

## Use this script to handle your prefix however you want!
export WINEPREFIX=$HOME/.WineLike
export PATH=/home/$USER/.local/share/winelike/wine-tkg/bin:$PATH

function Help(){
    Echo "Quick guide on how to use this script:"
    Echo "winelike --kill: Kills WineLike if hanging!"
    Echo "winelike --winecfg: Runs winecfg on prefix"
    Echo "winelike --regedit: Runs regedit on prefix"
    Echo "winelike --winetricks: Runs winetricks on prefix"
    Echo "winelike --remove: Removes WineLike from PC"
    Echo "winelike: prints this! :3"
}

case $1 in
    '')
    Help
    ;;

    '--kill')
    wineserver -k
    ;;

    '--winecfg')
    winecfg
    ;;

    '--regedit')
    regedit
    ;;

    '--remove')
    Echo "Uninstalling WineLike.."
    rm -rf ~/.WineLike
    rm -rf "$HOME/.local/share/winelike"
    rm "$HOME/.local/share/applications/WineLike.desktop"
    sudo rm /usr/local/bin/winelike
    Echo "Uninstall finished!!"
    ;;
esac