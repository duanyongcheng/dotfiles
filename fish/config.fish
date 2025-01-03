# $figlet -f fuzzy fish
#  .--. _       .-.
# : .-':_;      : :
# : `; .-. .--. : `-.
# : :  : :`._-.': .. :
# :_;  :_;`.__.':_;:_;
#
# Theo's Fish config

# Env var
set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME "$HOME/.config"

# Personal variables
# tilde expansion in quote doesn't work, so either use ~/My\ Drive or $HOME
set -gx CACHE_DIR "$HOME/My Drive/l1-cache"
set -gx CLOUD_DIR "$HOME/My Drive"
set -gx DOT_DIR ~/dotfiles

set -gx QUICK_NOTE_PATH "$CACHE_DIR/quick-note.md"
set -gx DAILY_WRITING_DIR "$CACHE_DIR/dw-$(date +'%Y')"

switch $(uname)
    case Linux
        set -x OSTYPE Linux
    case Darwin
        set -x OSTYPE macOS
    case '*BSD' DragonFly
        set -x OSTYPE BSD
    case '*'
        set -x OSTYPE UNKNOWN
end

if [ $OSTYPE = Linux ]
    nvm use stable
    fish_add_path $HOME/.config/tmux/plugins/tmuxifier/bin
    export NIX_PATH="~/.nix-defexpr/channels_root/nixpkgs"
    export PATH="$HOME/.cargo/bin:/usr/bin:/nix/store:$NIX_PATH:$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh:$PATH"
    fish_add_path ~/.local/share/bob/nvim-bin
end

if [ $OSTYPE = macOS ]
    nvm use stable
    fish_add_path ~/.cargo/bin/
    fish_add_path /opt/homebrew/bin/
    fish_add_path /opt/homebrew/Cellar/nushell/0.97.1/bin
    fish_add_path ~/.local/share/bob/nvim-bin
    fish_add_path /Applications/Docker.app/Contents/Resources/bin
    fish_add_path $HOME/.config/tmux/plugins/tmuxifier/bin
    fish_add_path ~/code/sdk/flutter/flutter_3.10.3/bin
    [ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish
    export https_proxy=http://127.0.0.1:6152;export http_proxy=http://127.0.0.1:6152;export all_proxy=socks5://127.0.0.1:6153
    export AGENT_DEBUG_OVERRIDE_PROXY_URL=https://cocopilot.org GITHUB_COPILOT_OVERRIDE_PROXY_URL=https://cocopilot.org AGENT_DEBUG_OVERRIDE_CAPI_URL=https://cocopilot.org GITHUB_COPILOT_OVERRIDE_CAPI_URL=https://cocopilot.org
    export JAVA_HOME="/opt/homebrew/Cellar/openjdk@11/11.0.24/libexec/openjdk.jdk/Contents/Home"

end

function fish_greeting -d "Theo's Custom Greetin Msg"
    # Getting the battery info
    set -l batlv -1
    if [ $OSTYPE = Linux ]
        # if test -a /sys/class/power_supply/BAT0/capacity
        #   set batlv $(cat /sys/class/power_supply/BAT0/capacity)
        # elif -a /sys/class/power_supply/BAT1/capacity
        #   set batlv $(cat /sys/class/power_supply/BAT1/capacity)
        # end
    else if command -v pmset &>/dev/null
        set batlv $(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
    end

    # Colors
    set -l normal (set_color normal)
    set -l cyan (set_color -o cyan)
    set -l brcyan (set_color -o brcyan)
    set -l green (set_color -o green)
    set -l brgreen (set_color -o brgreen)
    set -l red (set_color -o red)
    set -l brred (set_color -o brred)

    set -l blue (set_color -o blue)
    set -l brblue (set_color -o brblue)
    set -l magenta (set_color -o magenta)
    set -l brmagenta (set_color -o brmagenta)
    set -l yellow (set_color -o yellow)
    set -l bryellow (set_color -o bryellow)

    # Setting battery colors
    if [ $batlv -eq 1 ]
        set batcolo $red
        set batlv "Error in the battery "
    else if [ $batlv -ge 80 ]
        set batcolo $brcyan
    else if [ $batlv -gt 40 ]
        set batcolo $green
    else
        set batcolo $red
    end

    # Collection of Oliver ASCII arts
    set -l olivers \
        '
       \/   \/
       |\__/,|     _
     _.|o o  |_   ) )
    -(((---(((--------
    ' \
        '
       \/       \/
       /\_______/\
      /   o   o   \
     (  ==  ^  ==  )
      )           (
     (             )
     ( (  )   (  ) )
    (__(__)___(__)__)
    ' \
        '
                           _
          |\      _-``---,) )
    ZZZzz /,`.-```    -.   /
         |,4-  ) )-,_. ,\ (
        ---``(_/--`  `-`\_)
    ' \
        # Thanks Jonathan for the one below
        '
          \/ \/
          /\_/\ _______
         = o_o =  _ _  \     _
         (__^__)   __(  \.__) )
      (@)<_____>__(_____)____/
        ♡ ~~ ♡ OLIVER ♡ ~~ ♡
    ' \
        '
       \/   \/
       |\__/,|        _
       |_ _  |.-----.) )
       ( T   ))        )
      (((^_(((/___(((_/
    ' \
        '
    You found the only "fish" that Oliver could not eat!
           .
          ":"
        ___:____     |"\/"|
      ,`        `.    \  /
      |  O        \___/  |
    ~^~^~^~^~^~^~^~^~^~^~^~^~
    '
    # set -l oliver "$(random choice $olivers)" # will break new line without the quotes

    # Other information
    set -l my_hostname $(hostname -s) # -s to trim domain, hostname variable is taken by Fish
    set -l timestamp $(date -I) $(date +"%T")
    set -l uptime $(uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $2" "$3 " " }')

    # Print the msg
    echo
    echo -e "  " "$brgreen" "Welcome back $USER!" "$normal"
    echo -e "  " "$brred" "$oliver" "$normal"
    echo -e "  " "$yellow" " Fish Open:\t" "$bryellow$timestamp" "$normal"
    echo -e "  " "$blue" " Hostname :\t" "$brmagenta$my_hostname" "$normal"
    echo -e "  " "$magenta" " Uptime   :\t" "$brblue$uptime" "$normal"
    echo -e "  " "$cyan" "󱈏 Battery  :\t" "$batcolo$batlv%" "$normal"
    echo
end

function fish_right_prompt -d "Theo's custom right prompt displaying command duration"
    set -l __last_command_duration $CMD_DURATION

    set -l colo (set_color -o magenta)

    if test $__last_command_duration -gt 1000
        set __last_command_duration (math $__last_command_duration / 1000) s
        set colo (set_color -o red)
    else
        set __last_command_duration $__last_command_duration ms
    end
    echo $colo $__last_command_duration (set_color normal)
end

if status is-interactive

    set -l func_dir ~/.config/fish/alias.fish
    [ -f $func_dir ] && source $func_dir || echo -e (set_color -o red) "[ERR] $func_dir does not exist!"

    # Enable Vi keybinding
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_vi_force_cursor
end


# pnpm
set -gx PNPM_HOME /Users/bary/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
    eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /opt/homebrew/Caskroom/miniconda/base/bin $PATH
    end
end
# <<< conda initialize <<<


starship init fish | source
eval (tmuxifier init - fish)
