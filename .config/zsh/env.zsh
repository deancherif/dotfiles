#!/usr/bin/env zsh

export GOPATH=$HOME/dev/go
export CGO_ENABLED=1

export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons
export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.cargo/bin:$HOME/.local/share/gem/ruby/3.3.0/bin"
export PATH="$PATH:$(yarn global bin)"
GPG_TTY=$(tty)
export GPG_TTY

