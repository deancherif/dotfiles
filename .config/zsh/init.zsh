#!/usr/bin/env zsh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
. "$HOME/.asdf/asdf.sh"
eval $(ssh-agent -s) 1> /dev/null
fpath=(${ASDF_DIR}/completions $fpath)

export PATH="$PATH:$(yarn global bin)"

eval "$(zoxide init --cmd cd zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
eval "$(starship init zsh)"
