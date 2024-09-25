#!/bin/bash
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=500
SAVEHIST=500
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export TERM=xterm-256color

# CUSTOM ALIASES
alias grep="grep --color='auto'"
alias cat='/bin/bat'
alias catn='/bin/bat --paging=never'
alias ls='lsd -lah --group-dirs first --color=auto'
alias v='nvim'
alias vim='nvim'
alias r='ranger'

#KEYBINDINGS

bindkey "^[[H" beginning-of-line # TECLA INICIO ME MANDA AL PRINCIPIO
bindkey "^[[F" end-of-line # TECLA FIN ME MANDA AL FINAL DE LA LINEA
bindkey "^[[3~" delete-char # TECLA SUPR ME BORRA UN CARACTER
bindkey "^[[1;3C" forward-word # TECLA ALT + FLECHA DERECHA FINAL O COMIENZO DE PALABRA
bindkey "^[[1;3D" backward-word  # TECLA ALT + FLECHA IZQUIERDA  FINAL O COMIENZO DE PALABRA

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# Fix fzf search hidden files
export FZF_DEFAULT_COMMAND='find . -type f \( ! -iname ".*" \) -print -o -type d -name ".*" -print 2> /dev/null | sed 1d'
export FZF_CTRL_T_COMMAND='find . -type f \( ! -iname ".*" \) -print -o -type d -name ".*" -print 2> /dev/null | sed 1d'

function fzf-lovely(){

	if [ "$1" = "h" ]; then
		fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
 	               echo {} is a binary file ||
	                (bat --style=numbers --color=always {} ||
	                 highlight -O ansi -l {} ||
	                 coderay {} ||
	                 rougify {} ||
	                 cat {}) 2> /dev/null | head -500'

	else
	       fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
	                        echo {} is a binary file ||
	                        (bat --style=numbers --color=always {} ||
	                         highlight -O ansi -l {} ||
	                         coderay {} ||
	                         rougify {} ||
	                         cat {}) 2> /dev/null | head -500'
	fi
}

function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

function mantenimiento(){
    # Actualizar la base de datos de paquetes
    sudo pacman -Syyy --noconfirm
    # Actualizar los paquetes del sistema
    sudo pacman -Syyu --noconfirm
    # Actualizar los paquetes de AUR
    paru -Syyu --noconfirm
    # Limpiar la caché de paquetes
    sudo pacman -Sc --noconfirm
    # Limpiar el historial de instalación de paquetes
    sudo pacman -Scc --noconfirm
    # Limpiar la caché de AUR
    paru -Sc --noconfirm
    paru -Scc --noconfirm
    # Limpiar los archivos de registro antiguos
    sudo journalctl --vacuum-size=50M
    # Limpiar los archivos de registro antiguos de paquetes
    sudo journalctl --vacuum-time=2weeks
    # Limpiar la memoria caché de DNS
    sudo systemd-resolve --flush-caches
    # Limpiar la caché
    #    sudo find / -type d -name "Cache_Data" -empty -exec rm -rf {} \; -delete # bastante bruto (no recomendado)
    sudo rm -rf /home/doblux/.config/discord/Cache/Cache_Data/*
    sudo rm -rf /home/doblux/.cache/*
    sudo rm -rf /root/.cache/*
    sudo rm -rf /home/doblux/.vim/undodir/*
    # Limpiar el historial del shell
    sudo echo "" > $HOME/.zsh_history
    sudo echo "" > $HOME/.gdb_history
    # mirrorlist
    sudo reflector --verbose --latest 30 --protocol=https --sort rate --save /etc/pacman.d/mirrorlist
    # check systemd failed services
    sudo systemctl --failed
    # Check Log Files
    sudo journalctl -p 3 -b
}

function extract(){
 if [ $# -eq 0 ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso|.zst>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 fi
    for n in "$@"; do
        if [ ! -f "$n" ]; then
            echo "'$n' - file doesn't exist"
            return 1
        fi

        case "${n%,}" in
          *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                       tar zxvf "$n"       ;;
          *.lzma)      unlzma ./"$n"      ;;
          *.bz2)       bunzip2 ./"$n"     ;;
          *.cbr|*.rar) unrar x -ad ./"$n" ;;
          *.gz)        gunzip ./"$n"      ;;
          *.cbz|*.epub|*.zip) unzip ./"$n"   ;;
          *.z)         uncompress ./"$n"  ;;
          *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar|*.vhd)
                       7z x ./"$n"        ;;
          *.xz)        unxz ./"$n"        ;;
          *.exe)       cabextract ./"$n"  ;;
          *.cpio)      cpio -id < ./"$n"  ;;
          *.cba|*.ace) unace x ./"$n"     ;;
          *.zpaq)      zpaq x ./"$n"      ;;
          *.arc)       arc e ./"$n"       ;;
          *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                            extract "$n.iso" && \rm -f "$n" ;;
          *.zlib)      zlib-flate -uncompress < ./"$n" > ./"$n.tmp" && \
                            mv ./"$n.tmp" ./"${n%.*zlib}" && rm -f "$n"   ;;
          *.dmg)
                      hdiutil mount ./"$n" -mountpoint "./$n.mounted" ;;
          *.tar.zst)  tar -I zstd -xvf ./"$n"  ;;
          *.zst)      zstd -d ./"$n"  ;;
          *)
                      echo "extract: '$n' - unknown archive method"
                      return 1
                      ;;
        esac
    done
}

function work(){
    FILE=$(find $1 -not -path '*/.git/*' | fzf-lovely)
    if [ -d $FILE ]; then
        cd $FILE
    else
        nvim $FILE
    fi
}

function pdf_dark_mode(){
    echo "viewer.style = 'filter: grayscale(1) invert(1) sepia(1)'" | xclip -sel clip
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
