# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

source conf/index.nu
source completions/index.nu

# https://github.com/nushell/nu_scripts/blob/main/example-config/init.nu
# we need to export the env we create with load-env
# because we are `use`-ing here and not `source`-ing this file
export-env {
    load-env {
        BROWSER: "firefox"
        EDITOR: "nvim"
        VISUAL: "nvim"
        PAGER: "less"
        JULIA_NUM_THREADS:  nproc
        HOSTNAME:  (hostname | split row '.' | first | str trim)
        SHOW_USER: true
        LS_COLORS: ([
             "di=01;34;2;102;217;239"
             "or=00;40;31"
             "mi=00;40;31"
             "ln=00;36"
             "ex=00;32"
        ] | str join (char env_sep))
    }
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# config set startup ["starship init nu | save ~/.cache/starship/init.nu" "source ~/.cache/starship/init.nu"]
# source ~/.cache/starship/init.nu
