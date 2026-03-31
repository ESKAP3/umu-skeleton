# umu-skeleton
A lightweight, location-agnostic structure for managing Windows games using umu-launcher.

# Quick Start

- Initialize a Prefix:
  1. Open create_prefix.sh.
  2. Change xx to your desired game name.
  3. Run the script to build the environment.
  
- Set Your Runner:
  1. Drop your Proton folders into the runners directory. (Leave it empty to automatically download and use umu's Proton version and skip the next two steps.)
  2. Open runners/set_current.sh and update the folder name in the ln -sfn command.
  3. Run the script to create/update the 'current' symlink.
  
- Create a Launcher:
  1. Copy/edit games/game_template.sh.
  2. Update WINEPREFIX to match your prefix name.
  3. Paste the path to your game's .exe in the umu-run line.
  
If a Game gets stuck and won't close, open kill_game.sh, change xx to the game's prefix and run it.

Note: If the scripts don't run, ensure they are executable by running 'chmod +x *.sh games/*.sh runners/*.sh' in the root folder.

# Features

Portable: Uses BASE_DIR logic to calculate paths relative to the script location.
You can just move the folder around to your heart's content, including external drives and other Linux machines. It will work as long as umu-launcher is installed.
If something is weird after, run 'umu-run wineboot -u' in the prefix.

Lightweight: A directory structure with a few shell scripts. No overhead, no bullshit. Be your own manager.

Agnostic: Works with any Proton version dropped into the runners/ folder. (Wine works too but umu is made for Proton.)

The logic is simple af, if something doesn't work, it's not the script's fault. (As long as you keep the structure and follow instructions)
If you have any QoL suggestions, please make yourself heard!

Enjoy!
