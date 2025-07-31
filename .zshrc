# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ! History
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ! Completion styling

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"


# ! Aliases
alias c="clear"
alias cd="z"
# cf means "config", src means "source"
alias src="source ~/.zshrc"
alias cf-zsh="code ~/.zshrc"
alias cf-bat="code ~/.config/bat/config"
alias cf-tldr="code ~/.config/tealdeer/config.toml"
alias cf-fastfetch="code ~/.config/fastfetch/config.jsonc"
alias cf-wezterm="code ~/.wezterm.lua"

alias gdl="gallery-dl"
alias lg="lazygit"
alias cat="bat"
alias ls="eza --icons=always --all --group-directories-first"
alias et="eza --all --git-ignore --group-directories-first --tree"
alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'
alias rghs="rg --hidden --smart-case" # rg -.S
alias bg="batgrep"
alias bghs="batgrep --hidden --smart-case" # bg --hidden -S

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(thefuck --alias)"

export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND='fd  --type f --hidden --strip-cwd-prefix --exclude .git'
export FZF_ALT_C_COMMAND='fd --type d --hidden --strip-cwd-prefix --exclude .git'

source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Environment variables for ripgrep. Do not use quotes around the file path.
export RIPGREP_CONFIG_PATH=~/.dotfiles/.ripgreprc

# batman as replacement for man. Running "man" will use batman's syntax highlighting. However, "man" can't integrate with fzf selection like batman can.
eval "$(batman --export-env)"

# Yazi: cd to the current working directory of the yazi instance after quitting it.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ! Key bindings
# Ctrl+ArrowLeft or Ctrl+ArrowRight key word navigation
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
# Ctrl+Delete to kill forward word
bindkey '^[[3;5~' kill-word
# Ctrl+Backspace to kill backward word (assuming ^H is sent)
bindkey '^H' backward-kill-word
# Ctrl+z to undo
bindkey '^z' undo
# Use Ctrl+P/Ctrl+N to search through history
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

source /home/linuxbrew/.linuxbrew/share/powerlevel10k/powerlevel10k.zsh-theme
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	autoload -Uz compinit
	compinit
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

