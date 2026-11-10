# POINT NEMO shell hook: reports every finished command to `nemo shell` in the background
zmodload zsh/datetime
autoload -Uz add-zsh-hook
_nemo_preexec() { _nemo_cmd=$1; _nemo_t0=$EPOCHREALTIME }
_nemo_precmd() {
  local ec=$?
  [[ -n $_nemo_cmd ]] || return 0
  local dt=$(( EPOCHREALTIME - _nemo_t0 ))
  ( "$HOME/.local/bin/nemo" shell $ec ${dt%.*} "$_nemo_cmd" &>/dev/null & )
  _nemo_cmd=
}
add-zsh-hook preexec _nemo_preexec
precmd_functions=(_nemo_precmd ${precmd_functions:#_nemo_precmd})
