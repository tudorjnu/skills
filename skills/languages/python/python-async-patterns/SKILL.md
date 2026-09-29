---
name: python-async-patterns
description: 'Python asyncio patterns: the event loop, tasks, concurrent execution with gather, timeouts, and cancellation. Use when building async APIs or concurrent I/O systems, debugging a blocked event loop, or deciding between sync and async.'
---

# Python Async Patterns

Asynchronous Python with asyncio: the event loop, tasks, concurrent execution, timeouts, and the pitfalls that block or break async code.

## When to Use This Skill

- Building async web APIs (FastAPI, aiohttp)
- Running concurrent I/O operations (database, files, network)
- Handling many independent tasks at once
- Debugging a blocked event loop or unawaited coroutines
- Deciding whether a workload should be async at all

## Sync vs Async Decision Guide

Before adopting async, check whether it fits the workload.

| Use case | Recommended approach |
|---|---|
| Many concurrent network/DB calls | `asyncio` |
| CPU-bound computation | `multiprocessing` or a thread pool |
| Mixed I/O + CPU | Offload CPU work with `asyncio.to_thread()` |
| Simple scripts, few connections | Sync (simpler, easier to debug) |
| Web APIs with high concurrency | Async frameworks (FastAPI, aiohttp) |

**Key rule:** stay fully sync or fully async within a call path. Mixing creates hidden blocking and complexity.

## Core Concepts

1. **Event loop**: single-threaded cooperative scheduler; handles I/O without blocking
2. **Coroutines**: `async def` functions that can pause and resume
3. **Tasks**: scheduled coroutines that run concurrently on the loop
4. **Futures**: low-level objects representing eventual results
5. **Async context managers**: resources supporting `async with` for proper cleanup
6. **Async iterators**: sources supporting `async for`

## Quick Start

```python
import asyncio

async def main():
    print("Hello")
    await asyncio.sleep(1)
    print("World")

asyncio.run(main())
```

## Fundamental Patterns

### Pattern 1: Concurrent Execution with gather

```python
import asyncio

async def fetch_user(user_id: int) -> dict:
    """Fetch user data."""
    await asyncio.sleep(0.5)
    return {"id": user_id, "name": f"User {user_id}"}

async def fetch_all_users(user_ids: list[int]) -> list[dict]:
    """Fetch multiple users concurrently."""
    tasks = [fetch_user(uid) for uid in user_ids]
    return await asyncio.gather(*tasks)
```

### Pattern 2: Task Creation and Management

```python
import asyncio

async def background_task(name: str, delay: int):
    """Long-running background task."""
    print(f"{name} started")
    await asyncio.sleep(delay)
    print(f"{name} completed")
    return f"Result from {name}"

async def main():
    task1 = asyncio.create_task(background_task("Task 1", 2))
    task2 = asyncio.create_task(background_task("Task 2", 1))

    # Do other work while tasks run
    await asyncio.sleep(0.5)

    result1 = await task1
    result2 = await task2
    print(f"Results: {result1}, {result2}")

asyncio.run(main())
```

### Pattern 3: Error Handling in Async Code

```python
async def risky_operation(item_id: int) -> dict:
    """Operation that might fail."""
    await asyncio.sleep(0.1)
    if item_id % 3 == 0:
        raise ValueError(f"Item {item_id} failed")
    return {"id": item_id, "status": "success"}

async def safe_operation(item_id: int) -> dict | None:
    """Wrapper with error handling."""
    try:
        return await risky_operation(item_id)
    except ValueError as e:
        print(f"Error: {e}")
        return None

async def process_items(item_ids: list[int]):
    """Process multiple items, collecting failures."""
    tasks = [safe_operation(iid) for iid in item_ids]
    results = await asyncio.gather(*tasks, return_exceptions=True)

    successful = [r for r in results if r is not None and not isinstance(r, Exception)]
    failed = [r for r in results if isinstance(r, Exception)]

    print(f"Success: {len(successful)}, Failed: {len(failed)}")
    return successful
```

### Pattern 4: Timeout Handling

```python
import asyncio

async def slow_operation(delay: int) -> str:
    """Operation that takes time."""
    await asyncio.sleep(delay)
    return f"Completed after {delay}s"

async def with_timeout():
    """Execute operation with timeout."""
    try:
        result = await asyncio.wait_for(slow_operation(5), timeout=2.0)
        print(result)
    except asyncio.TimeoutError:
        print("Operation timed out")

asyncio.run(with_timeout())
```

## Common Pitfalls

### 1. Forgetting await

```python
# Wrong - returns coroutine object, doesn't execute
result = async_function()

# Correct
result = await async_function()
```

### 2. Blocking the Event Loop

```python
# Wrong - blocks the event loop
import time
async def bad():
    time.sleep(1)

# Correct
async def good():
    await asyncio.sleep(1)
```

### 3. Not Handling Cancellation

```python
async def cancelable_task():
    """Task that handles cancellation."""
    try:
        while True:
            await asyncio.sleep(1)
            print("Working...")
    except asyncio.CancelledError:
        print("Task cancelled, cleaning up...")
        raise  # Re-raise to propagate cancellation
```

### 4. Mixing Sync and Async Code

```python
# Wrong - can't call async from sync directly
def sync_function():
    result = await async_function()  # SyntaxError!

# Correct
def sync_function():
    result = asyncio.run(async_function())
```

## Testing Async Code

```python
import asyncio
import pytest

# Requires the pytest-asyncio plugin
@pytest.mark.asyncio
async def test_async_function():
    result = await fetch_data("https://api.example.com")
    assert result is not None

@pytest.mark.asyncio
async def test_with_timeout():
    with pytest.raises(asyncio.TimeoutError):
        await asyncio.wait_for(slow_operation(5), timeout=1.0)
```

---

Adapted from [wshobson/agents](https://github.com/wshobson/agents) at commit `156b7a5` (MIT, Copyright (c) 2024 Seth Hobson).
