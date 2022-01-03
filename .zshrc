# ~/.zshrc
#

# zsh plugins
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/history.zsh
source $HOME/.zsh/key-bindings.zsh

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
source $HOME/.zsh/aliases.zsh

# alias for proxy
export hostip=$(ip route | grep default | awk '{print $3}')
export hostport=10809
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
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

# rust
source "$HOME/.cargo/env"

# ros
#source /opt/ros/melodic/setup.zsh
source /opt/trunk_master/setup.zsh

# apollo
export APOLLO_ROOT_DIR=/home/xtp/code/github/apollo

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

######### Add config before here #########
#
# startship
eval "$(starship init zsh)"
