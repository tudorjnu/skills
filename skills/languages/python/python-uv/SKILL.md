---
name: python-uv
description: 'uv for Python dependency and environment management: project setup, dependencies, virtual environments, Python versions, and lockfiles. Use when creating Python projects, managing dependencies with uv, migrating from pip or poetry, or speeding up Python installs and CI.'
---

# Python uv

uv is a fast Python package installer and resolver, written in Rust, that also manages virtual environments, Python versions, and lockfiles. Its CLI replaces pip and venv workflows and understands `pyproject.toml` natively.

## When to Use This Skill

- Creating or migrating Python projects to uv
- Adding, upgrading, or removing dependencies
- Managing virtual environments without activation
- Installing and pinning Python versions
- Generating lockfiles for reproducible installs
- Migrating from pip, pip-tools, or poetry
- Speeding up dependency installs in CI

## Installation

```bash
# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows (PowerShell)
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"

# Or with an existing tool
pip install uv
brew install uv

uv --version  # Verify
```

## Quick Start

```bash
# Create a new project (pyproject.toml, .python-version, .venv)
uv init my-project
cd my-project

# Add dependencies (creates the venv if needed)
uv add requests pandas

# Add dev dependencies
uv add --dev pytest ruff

# Install everything from the lockfile
uv sync

# Run inside the project environment, no activation needed
uv run pytest
```

## Virtual Environments

```bash
uv venv                     # Create .venv
uv venv --python 3.12       # Specific Python version
uv venv --system-site-packages

# Activation (or skip it entirely with uv run)
source .venv/bin/activate

uv run python app.py
uv run --python 3.11 python script.py
```

## Dependency Management

```bash
uv add "django>=4.0,<5.0"                          # Version constraints
uv add --dev pytest pytest-cov                     # Dev group
uv add --optional docs sphinx                      # Optional group
uv add git+https://github.com/user/repo.git@v1.0.0 # Git source
uv add -e ./local-package                          # Editable local path

uv remove requests
uv sync --upgrade            # Upgrade all packages
uv tree --outdated            # Show what can upgrade
```

## Lockfiles

```bash
uv lock                      # Generate uv.lock
uv lock --upgrade            # Refresh the lockfile
uv lock --upgrade-package requests  # Upgrade one package
```

## Python Version Management

```bash
uv python install 3.12       # Install a version
uv python list               # What is available
uv python pin 3.12           # Set for the project (.python-version)
uv --python 3.11 run pytest  # One-off version
```

## Project Configuration

```toml
[project]
name = "my-project"
version = "0.1.0"
description = "A Python project"
requires-python = ">=3.10"
dependencies = [
    "requests>=2.31.0",
    "pydantic>=2.0.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.4.0",
    "ruff>=0.1.0",
    "mypy>=1.5.0",
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.uv.sources]
# Custom package sources
my-package = { git = "https://github.com/user/repo.git" }
```

## Migrating Existing Projects

```bash
uv add -r requirements.txt        # From a requirements file
uv sync                           # Existing pyproject.toml (poetry migrations)
uv pip freeze > requirements.txt  # Export back to requirements
```

---

Adapted from [wshobson/agents](https://github.com/wshobson/agents) at commit `156b7a5` (MIT, Copyright (c) 2024 Seth Hobson).
