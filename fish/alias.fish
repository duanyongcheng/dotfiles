# $ fish figlet -f fourtops fish
#  /~\'  |
# -|- |(~|/~\
#  |  |_)|   |
#
# Functions and aliases (which are just a wrapper for functions in Fish)

alias c clear
alias l "lsd -lh" # [A]lmost all (except . && ..), [l]ist, [h]: display unit
alias ls lsd # [A]lmost all (except . && ..), [l]ist, [h]: display unit
alias la "lsd -Alh"
alias weather "curl 'https://wttr.in'"
alias sc "source ~/.config/fish/config.fish"
alias lg lazygit
alias gcz gitcz
alias n neofetch
alias ds "docker stats"
alias vf "nvim ~/dotfiles/fish/config.fish"
alias v nixvim
alias jo joshuto
alias python python3

alias l1="cd \"$CACHE_DIR\""
alias dw="nvim \"$DAILY_WRITING_DIR/index.md\""
alias dot="cd \"$DOT_DIR\""
alias gpa="git push origin main; git push github main"
alias gp="git push"
alias uninstall_yabai="brew uninstall yabai skhd borders sketchybar"
alias install_yabai="brew install yabai skhd borders sketchybar"

# eza (better `ls`)
# ------------------------------------------------------------------------------
if command -v eza >/dev/null 2>&1
  alias l="eza --icons"
  alias ls="eza --icons"
  alias ll="eza -lg --icons"
  alias la="eza -lag --icons"
  alias lt="eza -lTg --icons"
  alias lt1="eza -lTg --level=1 --icons --ignore-glob='node_modules'"
  alias lt2="eza -lTg --level=2 --icons --ignore-glob='node_modules'"
  alias lt3="eza -lTg --level=3 --icons --ignore-glob='node_modules'"
  alias lta="eza -lTag --icons --ignore-glob='node_modules'"
  alias lta1="eza -lTag --level=1 --icons --ignore-glob='node_modules'"
  alias lta2="eza -lTag --level=2 --icons --ignore-glob='node_modules'"
  alias lta3="eza -lTag --level=3 --icons --ignore-glob='node_modules'"
end


# pnpm
alias pm="pnpm "

function cdf -d "Navigate to directories using fzf"
    set selected $(find * -maxdepth 1 -type d 2>/dev/null | fzf \
    --reverse --border=rounded --cycle --height=50% \
    --header='Pick a directory to navigate to')
    [ -z $selected ]; and echo 'Nothing was selected :('; or cd "$selected"
end

function fav -d "Navigate to my favorite directories using fzf"
    set -l fav_dir "$CLOUD_DIR" "$CACHE_DIR" "$DOT_DIR"
    set selected $(printf "%s\n" $fav_dir | fzf \
    --reverse --border=rounded --cycle --height=50% \
    --header='Pick a directory to navigate to')
    [ -z $selected ]; and echo 'Nothing was selected :('; or cd "$selected"
end

function mkcd -d "Create a directory and set CWD"
    command mkdir $argv
    if [ $status = 0 ]
        switch $argv[(count $argv)]
            case '-*'

            case '*'
                cd $argv[(count $argv)]
                return
        end
    end
end

function note -d "A place to quickly write something down"
    set -l note "$QUICK_NOTE_PATH"
    if [ ! -e $note ]
        echo "# Quick Note

> A place to quickly write something down.
> Theo, please do not store info here long-term
> Move to other sources like Org-roam" >$note
    end
    nvim $note
end

function numfiles -d "Count the number of file in the directory"
    set -l num $(ls -A $argv | wc -l)
    [ -n $num ]; and echo "$num files in $argv"
end

function updater -d "Place to update all the different stuff"
    # Construct a lsit of stuff to update
    set -l stuff dotfiles 'doom emacs' theovim
    if [ $OSTYPE = Linux ]
        set -a stuff dnf flatpak
    else if [ $OSTYPE = macOS ]
        set -a stuff homebrew
    end

    while true
        # Prompt user and check for C-c and no input
        set selected $(printf "%s\n" $stuff | fzf \
      --reverse --border=rounded --cycle --height=50% \
      --header='[Updater] What are you updating today?')
        [ -z $selected ]; and echo '[Updater] Ending the updater...'; and return

        echo '[Updater] Updating' $selected '...'
        switch $selected
            case dotfiles
                cd ~/dotfiles/ && git pull && cd - &>/dev/null
            case 'doom emacs'
                ~/.emacs.d/bin/doom upgrade
            case theovim
                cd ~/.config/nvim && git pull && cd - &>/dev/null
            case dnf
                sudo dnf upgrade
            case flatpak
                flatpak upgrade
            case homebrew
                brew upgrade
                brew update
                brew cleanup
                echo "[Updater] Perodically 'brew untap' unnecessary sources"
            case '*'
                echo "[Updater] Error. Switch couldn't match anything -- this shoudln't happen"
                return
        end # End switch
    end # End while true
end
