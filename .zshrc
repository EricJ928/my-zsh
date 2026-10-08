source ~/.zprofile
source ~/.aliases

# # AWS Commons
# source ~/.aws_functions_local
# source ~/.aws_envs_individual
# source ~/.aws_envs_ai-hub-sin-lob-b-dev

# # Claude Code
# export PATH="$HOME/.local/bin:$PATH"

# Dynamic uv virtual environment routing outside OneDrive
update_uv_env() {
    if command -v uv &> /dev/null; then
        # Dynamically calculate hash and folder name based on your active location
        PATH_HASH=$(echo -n "$PWD" | md5 | cut -c 1-6)
        export UV_PROJECT_ENVIRONMENT="$HOME/.virtualenvs/$(basename "$PWD")_${PATH_HASH}_venv"
    fi
}

# Run it when a new terminal window opens
update_uv_env

# Run it automatically every single time you use the 'cd' command
autoload -U add-zsh-hook
add-zsh-hook chpwd update_uv_env
