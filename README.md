# dotfiles

## install(mac/ubuntu)

```bash
bash <(curl -sL https://github.com/knsugiyama/dotfiles/raw/main/setup.sh)
cd .dotfiles
make install
make deploy
```

## install(windows)

```ps1
Invoke-WebRequest -Uri https://raw.githubusercontent.com/knsugiyama/dotfiles/main/setup.ps1 -OutFile setup.ps1
.\setup.ps1
make deploy
```
