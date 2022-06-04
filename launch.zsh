# ~/.zshrc
#

spaceport=$(dirname $0)

# zsh plugins
source ${spaceport}/zsh/aliases.zsh
source ${spaceport}/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${spaceport}/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ${spaceport}/zsh/plugins/completion.zsh
source ${spaceport}/zsh/plugins/history.zsh
source ${spaceport}/zsh/plugins/key-bindings.zsh
source ${spaceport}/zsh/plugins/extract.plugin.zsh
source ${spaceport}/zsh/plugins/sudo.plugin.zsh
source ${spaceport}/zsh/plugins/_ag

# Initialize the completion system
autoload -Uz compinit

# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# Enhanced form of menu completion called `menu selection'
zmodload -i zsh/complist

# alias
alias vim='nvim'

# alias for proxy
export hostip=$(ip route | grep default | awk '{print $3}')
export hostport=10811
alias proxy='
    export HTTPS_PROXY="http://${hostip}:${hostport}";
    export HTTP_PROXY="http://${hostip}:${hostport}";
    export ALL_PROXY="http://${hostip}:${hostport}";
'
alias unproxy='
    unset HTTPS_PROXY;
    unset HTTP_PROXY;
    unset ALL_PROXY;
'

# system path
export PATH=$HOME/.local/bin:$PATH

# rust
source "$HOME/.cargo/env"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

######### Add config before here #########
#
# starship
export STARSHIP_CONFIG=${spaceport}/starship/starship.toml
eval "$(starship init zsh)"
