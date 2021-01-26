autoload -Uz compinit
compinit

source <(kubectl completion zsh)

echo 'alias k=kubectl' >>~/.zshrc
echo 'complete -F __start_kubectl k' >>~/.zshrc


echo 'alias kns=kubens' >>~/.zshrc
echo 'alias kctx=kubectx' >>~/.zshrc
