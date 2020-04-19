set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)
set -x PATH "/usr/local/opt/openjdk/bin" $PATH
set -x PATH "/usr/local/opt/icu4c/bin" $PATH
set -x PATH "/usr/local/opt/icu4c/sbin" $PATH
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
set -x PATH $HOME/.jenv/bin $PATH
status --is-interactive; and source (jenv init -|psub)
set -x JAVA_HOME (jenv prefix)
