alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..

alias cp = cp -i
alias mv = mv -i
alias rm = rm -i

alias v = nvim
alias vi = nvim
alias vim = nvim

alias grep = rg

alias c = clear

if $nu.os-info.name == "macos" {
    alias cat = bat --theme="Dracula"
} else if $nu.os-info.name == "linux" {
    alias cat = bat --theme="Dracula"
} else if $nu.os-info.name == "windows" {
} else {
    print "Unknown OS"
}
