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

```zsh
mkdir ~/.virtualenvs
```

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

## 5. Set up Github Personal Access Token (PAT)

1. Generate a PAT on Github UI: Avatar -> Settings -> Developer settings -> Personal access tokens -> Token (classic) -> generate a new token
2. Configure Git to use macOS Keychain.
```zsh
git config --global credential.helper osxkeychain
```
3. Set your PAT
```zsh
git credential-osxkeychain store
```
Your terminal will wait for input. Paste the following (ONE LINE AT A TIME!), replacing the placeholders with your actual details:
```zsh
protocol=https
host=github.tools.sap
username=YOUR_GITHUB_USERNAME
password=YOUR_PERSONAL_ACCESS_TOKEN
```
Press Enter on the blank line after password=... to submit the credentials. The token itself won't be masked while you type or paste it into this input, so avoid doing this where others can see your screen.

## Local LaTeX with VS Code

1. Install `mactex-no-gui` (~7GB). This version includes full LaTeX packages. If storage is a concern, install `basictex` instead. But more likely you will need to install individual packages later on.
```zsh
brew install --cask mactex-no-gui
```
2. Verify
```zsh
pdflatex --version
latexmk --version
bibtex --version
```
3. In VS Code, install `LaTeX Workshop` extension.


