# my-zsh

## Steps

1. Change shell to zsh
```zsh
chsh -s /bin/zsh
echo $SHELL
```
2. Install `zsh-autosuggestions` and `zsh-syntax-highlighting`
```zsh
brew install zsh-autosuggestions zsh-syntax-highlighting
```
3. Insert all dot files to respective original files (at start)
4. For VS code shell integration:
5. Open Settings `cmd` + `,`, search for "Terminal › Integrated › Default Profile: Osx". Change it to "zsh"
