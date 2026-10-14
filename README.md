# my-zsh

## 1. Shell setup

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

## 2. Install packages

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

## 3. Set uv to work with OneDrive

By default, uv installs venv under the repo dir. This create a massive syncing overhead if the repo is under OneDrive, as .venv normally contains large number of small files (>30,000 often).

In the `.zshrc` in this repo, we set the `UV_PROJECT_ENVIRONMENT` to `$HOME/.virtualenvs/$(basename "$PWD")_${PATH_HASH}_venv` to keep venv out of the repo.

**Follow these steps:**

1. Use the setting in .zshrc. In this case, all uv installed venv will be under a central location `.virtualenvs/` and with the name of `RepoName_RepoPathHash_venv`. The path hash is to avoid name clash if 2 repos have the same name.
2. To activate the env in terminal, run:
```zsh
echo $UV_PROJECT_ENVIRONMENT
source $UV_PROJECT_ENVIRONMENT/bin/activate
```
Then run:
```zsh
python --version
which python
python main.py
```
To leave the environment:
```zsh
deactivate
```
3. Directly run python via uv w/o activating the env in terminal:
```zsh
uv run python --version
uv run python main.py
uv pip install package
```

>[!TIP]
>Note: `uv run` can synchronize the project environment with your project configuration before running. If you only want to run Python without automatic synchronization, use `uv run --no-sync python main.py`.

4. To make VS Code Python Interpreter auto detects central uv env: `cmd`+`shift`+`P`, then type and select `Preferences: Open User Settings (JSON)`. Add or update these settings:
```json
{
    "workbench.iconTheme": "material-icon-theme",
    "workbench.colorTheme": "One Dark Pro",
    "terminal.integrated.defaultProfile.osx": "zsh",
    "python.venvPath": "${env:HOME}/.virtualenvs",
    "python.condaPath": "/opt/homebrew/Caskroom/miniforge/base/bin/conda",
    "python.terminal.activateEnvironment": true
}
```

>[!WARNING]
>The setting above also includes icon & color theme, default shell for integrated terminal, and conda env path. Update them accordingly.

## 4. OneDrive sync on git repos

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
