# https://asdf-vm.com/guide/getting-started.html
git clone https://github.com/asdf-vm/asdf.git $HOME\.asdf

sudo New-Item -ItemType SymbolicLink -Force -Path $HOME\.asdf\.tool-versions -Target $HOME\.config\asdf\.tool-versions
