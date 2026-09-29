# Python skills

All model-invoked: they load automatically when the task fits, and any skill can also be called by name. Everything here is adapted from [wshobson/agents](https://github.com/wshobson/agents) (MIT) except where noted.

## Structure and style

- `python-project-structure`: directory layouts, module boundaries, `__all__` (original to this repo)
- `python-code-style`: PEP 8, naming, docstrings, linting setup
- `python-design-patterns`: KISS, SRP, separation of concerns, composition, rule of three
- `python-anti-patterns`: checklist of common mistakes with fixes

## Correctness

- `python-type-safety`: type hints, generics, protocols, strict mypy
- `python-testing-patterns`: pytest fixtures, mocking, markers, coverage
- `python-error-handling`: validation, exception design, partial failures
- `python-resilience`: retries, backoff, timeouts, circuit breakers

## Concurrency and operations

- `python-async-patterns`: event loop, tasks, gather, timeouts, pitfalls
- `python-background-jobs`: task queues, workers, event-driven processing
- `python-resource-management`: context managers, cleanup, streaming
- `python-observability`: structured logging, metrics, tracing
- `python-performance-optimization`: profiling, bottleneck analysis, memory

## Packaging and tooling

- `python-configuration`: env vars, pydantic-settings, per-environment config
- `python-packaging`: building, versioning, publishing to PyPI
- `python-uv`: dependency and environment management with uv