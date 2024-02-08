<h1 align="center"> WineLike 🍷</h1>
<p align="center"> Run your .exe files just like on Windows! 👻</p>

<p align="center">
  <img src="https://github.com/NelloKudo/WineLike/assets/98063377/80d184b2-843e-4169-adff-d62e198fc88d" alt="Your GIF" />
</p>

**WineLike** is a simple Wine wrapper designed to make running all your **.exe** files **within a unified WinePrefix**. This offers several advantages:

- Eliminating the need to use separate installations for every Windows program you'll ever want to launch
- Using a Wineprefix with all core Windows components already installed and working (dotnet, fonts, DX11/12..)
- Making it easier to run portable .exe files, just like on Windows
- Acting as a seamless drop-in replacement for repositories' Wine, but also supporting esync/fsync!

## Installation
- Make sure you have **Wine dependencies** installed before running the script or it won't work! 
  - [Lutris: Installing Wine and dependencies](https://github.com/lutris/docs/blob/master/WineDependencies.md)

- After that, paste the following in your terminal:
```
bash -c "$(wget -qO- https://raw.githubusercontent.com/NelloKudo/WineLike/main/winelike.sh)"
```
- Due to Winetricks installing Windows' core components, installation is going to take ~10/15 min. depending on your PC and connection. Please be patient! 🙏

## Usage
Right-clicking your .exe files and selecting 'Open with WineLike' should be enough to run your programs.

However, WineLike also provides a helper script aimed at managing WineLike's Wineprefix:
```
winelike --kill: Kills WineLike if hanging!
winelike --winecfg: Runs winecfg on prefix
winelike --regedit: Runs regedit on prefix
winelike --winetricks: Runs winetricks on prefix
winelike --remove: Removes WineLike from PC
winelike: prints this! :3"
```

## Credits
[Kron4ek's Wine Builds](https://github.com/Kron4ek/Wine-Builds) for providing the Wine binary used by WineLike!

[Winetricks](https://github.com/Winetricks/winetricks) for installing all Windows' core components 🙏

And that's all! Enjoy running your Windows programs, but better 🍷
