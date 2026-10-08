# my-zsh

## Steps

### Shell setup

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

### Install packages

1. uv
```zsh
brew install uv
uv --version
```
2. conda
```zsh
brew install miniforge
conda --version
which conda
conda env list
```
3. node, nvm, npm, npx

To set up your environment cleanly using Homebrew, you should only install NVM via brew, and then use NVM to install Node, NPM, and NPX.
```zsh
brew install nvm
```
Create a directory for NVM if it doesn't exist:
```zsh
mkdir ~/.nvm
```
Source zshrc
```zsh
source ~/.zshrc
```
Install the rest:
```zsh
nvm install --lts
```
Check if it works:
```zsh
npx @modelcontextprotocol/inspector
```

### OneDrive sync on git repos

For git repos stored on OneDrive, when they sync on new laptop from cloud, all files will be shown as `modified` in git status. This is because OneDrive sync set the executable bit (`+x`) on all your files when it reconstituted them on the new laptop. Git tracks that bit, so it reports every file as "modified."

Do this in every affected repo:
```zsh
git config core.fileMode false
git status
```
Or set it globally:
```zsh
git config --global core.fileMode false
```
This tells git to stop tracking the executable bit (`+x`).
