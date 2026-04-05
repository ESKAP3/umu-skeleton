![Logic Audit](https://github.com/ESKAP3/umu-skeleton/actions/workflows/lint.yml/badge.svg)
# umu-skeleton
Who needs a game manager, you have a filesystem.

dependencies: umu-launcher

# Quick Start
```bash
git clone https://github.com/ESKAP3/umu-skeleton.git && cd umu-skeleton
```
- Set Your Runner:
  1. Drop your Proton folders into the `runners/` directory, or use `tools/git_runners.sh` to get one (requires curl).
  2. Open `global.conf` and update `PROTONPATH` to point to your runner. (You can also set up each game individually) 
  
- Initialize a Prefix:
  1. Open `create_prefix.sh`.
  2. Specify your desired name at `PREFIX_NAME`.
  3. Run the script to build the environment. 
  
- Create a Launcher:
  1. Copy `games/game_template.sh`.
  2. Update `WINEPREFIX` to match your prefix name.
  3. Paste the path to your game's .exe in the `umu-run` line.

**Note:** If the scripts don't run, ensure they are executable by running this in the root folder:

```bash
chmod +x *.sh games/*.sh tools/*.sh
```

If a game acts up after moving to another drive/computer, point `create_prefix.sh` to the prefix and run it again.
Same goes for switching proton versions, not always needed, but fixes inconsistencies between how different versions handle a prefix.

# Features

Portable: Calculates paths relative to script location.
Move the folder around to your heart's content, including external drives and other Linux machines. It will work as long as umu-launcher is installed.

Lightweight: A directory structure with a few shell scripts. No overhead, no bullshit. Be your own manager.

Simple: Beginners can use it too, you might learn something.

Global config and local overrides.

There are now `winecfg.sh`, `explorer.sh` and `kill_game.sh` in `tools/` for easier management.

Logging: Every game script has a commented-out `tee` line. If a game fails to launch:
1. Uncomment that line.
2. Launch the game.
3. Check the hidden `.logs/` folder for `last_run_PREFIXNAME.log`. 
There's also an option to enable Proton's logs for deeper troubleshooting in `global.conf`, also writes to `.logs/`.

If you have any QoL suggestions, please make yourself heard!

Enjoy!
