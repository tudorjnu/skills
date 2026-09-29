---
name: python-type-safety
description: Python type safety with type hints, generics, protocols, and strict type checking. Use when adding type annotations, implementing generic classes, defining structural interfaces, or configuring mypy/pyright.
---

# Python Type Safety

Leverage Python's type system to catch errors at static analysis time. Type annotations serve as enforced documentation that tooling validates automatically.

## When to Use This Skill

- Adding type hints to existing code
- Creating generic, reusable classes
- Defining structural interfaces with protocols
- Configuring mypy or pyright for strict checking
- Understanding type narrowing and guards
- Building type-safe APIs and libraries

## Core Concepts

### 1. Type Annotations

Declare expected types for function parameters, return values, and variables.

### 2. Generics

Write reusable code that preserves type information across different types.

### 3. Protocols

Define structural interfaces without inheritance (duck typing with type safety).

### 4. Type Narrowing

Use guards and conditionals to narrow types within code blocks.

## Quick Start

```python
def get_user(user_id: str) -> User | None:
    """Return type makes 'might not exist' explicit."""
    ...

# Type checker enforces handling the None case
user = get_user("123")
if user is None:
    raise UserNotFoundError("123")
print(user.name)  # Type checker knows user is User here
```

## Fundamental Patterns

### Pattern 1: Annotate All Public Signatures

Every public function, method, and class should have type annotations.

```python
class UserRepository:
    def __init__(self, db: Database) -> None:
        self._db = db

    async def find_by_id(self, user_id: str) -> User | None:
        """Return User if found, None otherwise."""
        ...

    async def save(self, user: User) -> User:
        """Save and return user with generated ID."""
        ...
```

Use `mypy --strict` or `pyright` in CI to catch type errors early. For existing projects, enable strict mode incrementally with per-module overrides.

### Pattern 2: Use Modern Union Syntax

Python 3.10+ provides cleaner union syntax.

```python
# Preferred (3.10+)
def find_user(user_id: str) -> User | None:
    ...

def parse_value(v: str) -> int | float | str:
    ...

# Older style (needed for 3.9)
from typing import Optional

def find_user(user_id: str) -> Optional[User]:
    ...
```

### Pattern 3: Type Narrowing with Guards

Use conditionals to narrow types for the type checker.

```python
def process_user(user_id: str) -> UserData:
    user = find_user(user_id)

    if user is None:
        raise UserNotFoundError(f"User {user_id} not found")

    # Type checker knows user is User here, not User | None
    return UserData(
        name=user.name,
        email=user.email,
    )

def process_items(items: list[Item | None]) -> list[ProcessedItem]:
    valid_items = [item for item in items if item is not None]
    # valid_items is now list[Item]
    return [process(item) for item in valid_items]
```

### Pattern 4: Generic Classes

Create type-safe reusable containers.

```python
from typing import TypeVar, Generic

T = TypeVar("T")
E = TypeVar("E", bound=Exception)

class Result(Generic[T, E]):
    """Represents either a success value or an error."""

    def __init__(
        self,
        value: T | None = None,
        error: E | None = None,
    ) -> None:
        if (value is None) == (error is None):
            raise ValueError("Exactly one of value or error must be set")
        self._value = value
        self._error = error

    @property
    def is_success(self) -> bool:
        return self._error is None

    def unwrap(self) -> T:
        """Get value or raise the error."""
        if self._error is not None:
            raise self._error
        return self._value  # type: ignore[return-value]

    def unwrap_or(self, default: T) -> T:
        """Get value or return default."""
        if self._error is not None:
            return default
        return self._value  # type: ignore[return-value]

# Usage preserves types
def parse_config(path: str) -> Result[Config, ConfigError]:
    try:
        return Result(value=Config.from_file(path))
    except ConfigError as e:
        return Result(error=e)

result = parse_config("config.yaml")
if result.is_success:
    config = result.unwrap()  # Type: Config
```

## Advanced Patterns

### Pattern 5: Protocols for Structural Typing

Define interfaces without inheritance; any class with the right shape satisfies the protocol.

```python
from typing import Protocol, runtime_checkable

@runtime_checkable
class Serializable(Protocol):
    def to_dict(self) -> dict:
        ...

class User:  # No inheritance; shape is enough
    def __init__(self, id: str, name: str) -> None:
        self.id = id
        self.name = name

    def to_dict(self) -> dict:
        return {"id": self.id, "name": self.name}

def serialize(obj: Serializable) -> str:
    return json.dumps(obj.to_dict())

serialize(User("1", "Alice"))                # Accepted by the type checker
isinstance(User("1", "Alice"), Serializable)  # True with @runtime_checkable
```

### Pattern 6: TypeVar Bounds

Restrict generics to meaningful types.

```python
from typing import TypeVar
from pydantic import BaseModel

ModelT = TypeVar("ModelT", bound=BaseModel)

def validate_and_create(model_cls: type[ModelT], data: dict) -> ModelT:
    """Create a validated Pydantic model from a dict."""
    return model_cls.model_validate(data)

user = validate_and_create(User, {"name": "Alice"})  # Typed as User
validate_and_create(str, {"name": "Alice"})  # Type error: str is not a BaseModel
```

### Pattern 7: Type Aliases

```python
# Python 3.12+ (PEP 695)
type UserId = str
type Handler[T] = Callable[[Request], T]

# Python 3.10-3.11
from typing import TypeAlias
from collections.abc import Callable

UserId: TypeAlias = str
Handler: TypeAlias = Callable[[Request], Response]
```

The `type` statement needs 3.12+; use `TypeAlias` when targeting older Pythons.

## Strict Mode Configuration

```toml
# pyproject.toml
[tool.mypy]
python_version = "3.12"
strict = true
warn_return_any = true
warn_unused_ignores = true
disallow_untyped_defs = true
no_implicit_optional = true
```

Relax rules for specific modules with overrides instead of weakening the global config:

```toml
[[tool.mypy.overrides]]
module = "tests.*"
disallow_untyped_defs = false
```

`pyright` is a faster alternative checker:

```toml
[tool.pyright]
pythonVersion = "3.12"
typeCheckingMode = "strict"
```

Run `mypy --strict` in CI. For existing codebases, enable strict mode per module using the overrides above instead of migrating everything at once.

## Best Practices Summary

1. **Annotate all public APIs** - Functions, methods, class attributes
2. **Use `T | None`** - Modern union syntax over `Optional[T]`
3. **Run strict type checking** - `mypy --strict` in CI
4. **Use generics** - Preserve type info in reusable code
5. **Define protocols** - Structural typing for interfaces
6. **Narrow types** - Use guards to help the type checker
7. **Bound type vars** - Restrict generics to meaningful types
8. **Create type aliases** - Meaningful names for complex types
9. **Minimize `Any`** - Use specific types or generics. `Any` is acceptable for truly dynamic data or untyped third-party code
10. **Document with types** - Types are enforceable documentation

---

Adapted from [wshobson/agents](https://github.com/wshobson/agents) at commit `156b7a5` (MIT, Copyright (c) 2024 Seth Hobson).
