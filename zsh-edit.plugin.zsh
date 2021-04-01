#!/bin/zsh
setopt autopushd pushdminus
() {
  emulate -L zsh
  typeset -gHa _edit_opts=( extendedglob NO_listbeep rcquotes warncreateglobal )
  setopt $_edit_opts

  local fdir=${${(%):-%x}:h}/functions
  autoload -Uz $fdir/bindkey $fdir/_*~*.zwc

  local widget
  for widget in {forward,backward,kill,backward-kill}-word; do
    zle -N $widget _edit_subword
  done
  for widget in yank yank-pop reverse-yank-pop; do
    zle -N $widget _visual_yank
  done

  bindkey -M emacs '^[Y' reverse-yank-pop

  zle -N _dirstack
  bindkey -M emacs '^[`' _dirstack # Show dir stack.

  zle -N _pushd
  bindkey -M emacs '^[-' _pushd # Go back one dir.
  bindkey -M emacs '^[=' _pushd # Go forward one dir.

  bindkey -M menuselect '^[-' menu-complete
  bindkey -M menuselect '^[=' reverse-menu-complete
}
