---
name: python-packaging
description: 'Build and publish Python packages: pyproject.toml metadata, build backends, wheels and sdists, entry points, and PyPI publishing. Use when packaging Python libraries, creating CLI tools, or making Python code installable.'
---

# Python Packaging

Create, build, and distribute Python packages: pyproject.toml metadata, build backends, wheels and sdists, and publishing to PyPI.

## When to Use This Skill

- Creating Python libraries for distribution
- Building command-line tools with entry points
- Publishing packages to PyPI or private repositories
- Creating installable packages with dependencies
- Building wheels and source distributions
- Versioning and releasing Python packages
- Creating namespace packages
- Implementing package metadata and classifiers

## Core Concepts

### 1. Package Structure

- **Source layout**: `src/package_name/` (recommended)
- **Flat layout**: `package_name/` (simpler but less flexible)
- **Package metadata**: pyproject.toml, setup.py, or setup.cfg
- **Distribution formats**: wheel (.whl) and source distribution (.tar.gz)

### 2. Modern Packaging Standards

- **PEP 517/518**: Build system requirements
- **PEP 621**: Metadata in pyproject.toml
- **PEP 660**: Editable installs
- **pyproject.toml**: Single source of configuration

### 3. Build Backends

- **setuptools**: Traditional, widely used
- **hatchling**: Modern, opinionated
- **flit**: Lightweight, for pure Python
- **poetry**: Dependency management + packaging

### 4. Distribution

- **PyPI**: Python Package Index (public)
- **TestPyPI**: Testing before production
- **Private repositories**: JFrog, AWS CodeArtifact, etc.

## Quick Start

### Minimal Package Structure

```
my-package/
├── pyproject.toml
├── README.md
├── LICENSE
├── src/
│   └── my_package/
│       ├── __init__.py
│       └── module.py
└── tests/
    └── test_module.py
```

### Minimal pyproject.toml

```toml
[build-system]
requires = ["setuptools>=61.0"]
build-backend = "setuptools.build_meta"

[project]
name = "my-package"
version = "0.1.0"
description = "A short description"
authors = [{name = "Your Name", email = "you@example.com"}]
readme = "README.md"
requires-python = ">=3.8"
dependencies = [
    "requests>=2.28.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "black>=22.0",
]
```

## Package Structure Patterns

### Pattern 1: Source Layout (Recommended)

```
my-package/
├── pyproject.toml
├── README.md
├── LICENSE
├── .gitignore
├── src/
│   └── my_package/
│       ├── __init__.py
│       ├── core.py
│       ├── utils.py
│       └── py.typed          # For type hints
├── tests/
│   ├── __init__.py
│   ├── test_core.py
│   └── test_utils.py
└── docs/
    └── index.md
```

**Why src for distribution:** the installed package and the source tree are distinct, so tests exercise what users install rather than an accidental import of the working directory.

**pyproject.toml for source layout:**

```toml
[tool.setuptools.packages.find]
where = ["src"]
```

### Pattern 2: Layout Variants

Flat layouts and multi-package monorepos are directory-organization territory: call the Skill tool with "python-project-structure" for layouts and their trade-offs. For anything you intend to distribute, stay on the src layout from Pattern 1.

## Detailed patterns and worked examples

Detailed pattern documentation lives in `references/details.md`. Read that file when the navigation tier above is insufficient.

---

Adapted from [wshobson/agents](https://github.com/wshobson/agents) at commit `156b7a5` (MIT, Copyright (c) 2024 Seth Hobson).
