---
name: python-design-patterns
description: 'Python design patterns: KISS, single responsibility, separation of concerns, and composition over inheritance. Use when designing a new component or service, refactoring a God class or monolithic function, deciding whether to add an abstraction or live with duplication, choosing between inheritance and composition, or untangling I/O from business logic.'
---

# Python Design Patterns

Write maintainable Python code using fundamental design principles. These patterns help you build systems that are easy to understand, test, and modify.

## When to Use This Skill

- Designing new components or services
- Refactoring complex or tangled code
- Deciding whether to create an abstraction
- Choosing between inheritance and composition
- Evaluating code complexity and coupling
- Planning modular architectures

## Core Concepts

### 1. KISS (Keep It Simple)

Choose the simplest solution that works. Complexity must be justified by concrete requirements.

### 2. Single Responsibility (SRP)

Each unit should have one reason to change. Separate concerns into focused components.

### 3. Composition Over Inheritance

Build behavior by combining objects, not extending classes.

### 4. Rule of Three

Wait until you have three instances before abstracting. Duplication is often better than premature abstraction.

## Quick Start

```python
# Simple beats clever
# Instead of a factory/registry pattern:
FORMATTERS = {"json": JsonFormatter, "csv": CsvFormatter}

def get_formatter(name: str) -> Formatter:
    return FORMATTERS[name]()
```

## Pattern Catalog

| # | Pattern | One-liner |
|---|---|---|
| 1 | KISS | The simplest solution that works; complexity must be justified |
| 2 | Single Responsibility | One reason to change per unit |
| 3 | Separation of Concerns | Distinct layers: handler, service, repository |
| 4 | Composition over Inheritance | Combine objects, don't extend classes |
| 5 | Rule of Three | Wait for three instances before abstracting |
| 6 | Function Size | Keep functions small and single-purpose |
| 7 | Dependency Injection | Pass collaborators in; test with fakes |
| 8 | Avoiding Anti-Patterns | Don't leak ORM models or embed SQL in logic |

Patterns 1-4 are the fundamentals above; all eight have worked examples in `references/details.md`. Read that file when the catalog above is insufficient.

## Best Practices Summary

1. **Keep it simple** - Choose the simplest solution that works
2. **Single responsibility** - Each unit has one reason to change
3. **Separate concerns** - Distinct layers with clear purposes
4. **Compose, don't inherit** - Combine objects for flexibility
5. **Rule of three** - Wait before abstracting
6. **Keep functions small** - 20-50 lines (varies by complexity), one purpose
7. **Inject dependencies** - Constructor injection for testability
8. **Delete before abstracting** - Remove dead code, then consider patterns
9. **Test each layer** - Isolated tests for each concern
10. **Explicit over clever** - Readable code beats elegant code

## Troubleshooting

**A class is growing and seems to have multiple responsibilities, but splitting it feels wrong.**
Apply the "reason to change" test: list every change that could require editing this class. If the list has items from different domains (e.g., HTTP parsing AND business rules AND formatting), split it. If all changes stem from the same domain concern, the class may be appropriately sized.

**Injecting all dependencies through the constructor is producing constructors with 7+ parameters.**
This is a sign of too many responsibilities in one class, not a problem with dependency injection. Split the class into smaller units first, then each constructor naturally becomes smaller.

**Composition is producing deeply nested wrapper objects that are hard to trace.**
Keep the composition shallow (2-3 levels). If wrapping is the only mechanism, consider whether a Protocol-based approach or simple function composition would be cleaner than a chain of decorator objects.

**The rule of three says not to abstract yet, but the duplication is causing bugs when one copy is updated but not the other.**
Duplication that diverges in dangerous ways should be abstracted sooner. The rule of three is a heuristic, not a law. If the copies are already diverging incorrectly, extract immediately and add a test that exercises the shared behavior.

**A service layer is importing from the API layer, breaking the dependency direction.**
This is a layering violation. The service layer must not import from handlers. Introduce a shared types/models layer that both can import from, keeping the dependency arrow pointing downward (API → Service → Repository).

## Related Skills

- Call the Skill tool with "python-testing-patterns" to test each layer in isolation, using the dependency injection structure established here.
- Call the Skill tool with "python-project-structure" to organize modules and directory layout so layer boundaries are explicit from the start.

---

Adapted from [wshobson/agents](https://github.com/wshobson/agents) at commit `156b7a5` (MIT, Copyright (c) 2024 Seth Hobson).
