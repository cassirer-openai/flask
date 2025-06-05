#!/usr/bin/env bash
set -euo pipefail

# Exit if environment already built
if [ "${DEV_ENV_BUILT:-}" = "1" ]; then
    echo "Development environment already built."
    exit 0
fi

# Ensure running from repository root
cd "$(dirname "$0")"

# Ensure uv is installed
if ! command -v uv >/dev/null 2>&1; then
    if command -v pip >/dev/null 2>&1; then
        pip install --user uv || echo "# TODO: install uv"
        export PATH="$HOME/.local/bin:$PATH"
    else
        echo "# TODO: install uv (pip not found)"
    fi
fi

# Create virtual environment
if [ ! -d .venv ]; then
    uv venv .venv
fi

# Install dependencies from uv.lock and project in editable mode
uv sync
source .venv/bin/activate
uv pip install -e .
deactivate

# Mark environment as built
export DEV_ENV_BUILT=1
echo 'export DEV_ENV_BUILT=1' >> "$HOME/.profile"
