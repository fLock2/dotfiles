if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source

    # Aliases
    #alias in="paru -S"
    alias in="sudo dnf5 install"
    # alias dup="sudo dnf5 distro-sync && flatpak update && nix-env --upgrade && doom upgrade"
    alias dup="sudo dnf5 upgrade && flatpak update"
    # alias pup="sudo dnf5 upgrade && flatpak update"
    #alias dup="sudo pacman -Sy && sudo powerpill -Su && paru -Su && flatpak update"
    #alias rp="paru -R"
    alias rp="sudo dnf5 remove"
    #alias cleancache="sudo pacman -Scc && sudo powerpill -Scc && paru -Scc"
    alias cleancache="sudo dnf5 clean all"
    alias fuck='sudo $(fc -ln -1)'
    alias gcl="git clone"
    alias gcm="git commit -m"
    alias gpl="git pull"
    alias gph="git push"
    alias gad="git add"
    alias bw="flatpak run com.bitwarden.desktop"
    alias grm="git remove"
    alias em="emacsclient -c -a 'emacs'"
    alias srst="scrot ~/Pictures/Screenshots/%b%d::%H%M%S.png"
    alias crst="scrot -s ~/Pictures/Screenshots/%b%d::%H%M%S.png"
    alias vim="nvim"
    alias ncmpcpp="~/.ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug"
    alias xref="xrdb ~/.Xresources"
    #alias listpkg="comm -23 <(paru -Qqett | sort) <(paru -Qqg base -g base-devel | sort | uniq)"
    alias listpkg="dnf5 list --installed"
    #alias ls="exa -la"
    alias ls="eza"
    alias ll="eza -la"
    #alias lock="betterlockscreen -l"
    alias swlock="swaylock -i ~/Pictures/kinounderthestars.jpg --clock --effect-blur 3x5 --indicator-idle-visible --indicator-caps-lock --effect-vignette 0.5:0.5 --font 'Helvetica Neue' --bs-hl-color eb6f92ff --key-hl-color f6c177ff --inside-color 23213662 --inside-clear-color ea9a97ff --inside-ver-color 39355232 --inside-wrong-color eb6f9262 --text-color e0def4ff --text-clear-color e0def4ff --text-ver-color e0def4ff --text-wrong-color e0def4ff --ring-color c4a7e7ff --ring-clear-color ea9a97ff --ring-ver-color 3e8fb0ff --ring-wrong-color eb6f92ff"
    alias doom="~/.config/emacs/bin/doom"
    alias extract="unp"
    alias alcs="alacritty-colorscheme"
    #alias colortest="~/scripts/colortest.sh"
    #alias gputop="sudo intel_gpu_top"

    # alias cp="/usr/local/bin/cpg"
    alias cpv="/usr/local/bin/cpg -Rg"
    # alias mv="/usr/local/bin/mvg"
    alias mvv="/usr/local/bin/mvg -g"

end
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t -- $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -f backward-delete-char history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end
