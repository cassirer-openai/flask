#!/usr/bin/env bash
set -euo pipefail

# Exit if the environment has already been built
if [[ "${DEV_ENV_BUILT:-0}" == "1" ]]; then
    echo "codex_setup.sh: development environment already built."
    exit 0
fi

# Install runtime and development dependencies along with this project in editable mode
uv pip install --system --editable . --group dev --group pre-commit --group tests --group typing

# Mark the environment as built for subsequent sessions
export DEV_ENV_BUILT=1
if ! grep -qx 'export DEV_ENV_BUILT=1' "$HOME/.profile"; then
    echo 'export DEV_ENV_BUILT=1' >> "$HOME/.profile"
fi

echo "codex_setup.sh: success"
