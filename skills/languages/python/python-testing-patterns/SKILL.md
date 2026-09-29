---
name: python-testing-patterns
description: 'Python testing with pytest: fixtures, mocking, parametrization, markers, and coverage. Use when writing Python tests, setting up test suites or conftest files, mocking external dependencies, or debugging failing tests.'
---

# Python Testing Patterns

Testing strategies in Python with pytest: fixtures for setup and teardown, mocking, parametrization, markers, and coverage reporting.

## When to Use This Skill

- Writing unit or integration tests for Python code
- Setting up test suites, conftest files, and shared fixtures
- Mocking external dependencies and services
- Parametrizing tests over many input cases
- Measuring and enforcing coverage
- Debugging failing tests

For testing async code, call the Skill tool with "python-async-patterns"; it covers pytest-asyncio.

## Core Concepts

### 1. Test Types

- **Unit Tests**: Test individual functions and classes in isolation
- **Integration Tests**: Test interaction between components
- **Functional Tests**: Test complete features end-to-end

### 2. Test Structure (AAA Pattern)

- **Arrange**: Set up test data and preconditions
- **Act**: Execute the code under test
- **Assert**: Verify the results

### 3. Test Isolation

- Tests should be independent, with no shared state between them
- Each test should clean up after itself
- Aim for meaningful coverage, not high percentages

## Quick Start

```python
# test_example.py
def add(a, b):
    return a + b

def test_add():
    """Basic test example."""
    assert add(2, 3) == 5

def test_add_negative():
    """Test with negative numbers."""
    assert add(-1, 1) == 0

# Run with: pytest test_example.py
```

## Fixtures for Setup and Teardown

```python
# test_database.py
import pytest

@pytest.fixture
def db():
    """Fixture providing a connected database, torn down after the test."""
    database = Database("sqlite:///:memory:")
    database.connect()
    yield database          # test runs here
    database.disconnect()  # teardown

def test_database_query(db):
    results = db.query("SELECT * FROM users")
    assert results[0]["name"] == "Test"
```

Fixture scope controls how often setup runs, and fixtures can depend on other fixtures:

```python
@pytest.fixture(scope="session")
def app_config():
    """Created once per test session."""
    return {"database_url": "postgresql://localhost/test"}

@pytest.fixture(scope="module")
def api_client(app_config):
    """Created once per test module."""
    client = ApiClient(app_config)
    yield client
    client.close()
```

## Parametrized Tests

One test body, many cases; pytest reports each case as its own test.

```python
import pytest

@pytest.mark.parametrize("email,expected", [
    ("user@example.com", True),
    ("test.user@domain.co.uk", True),
    ("invalid.email", False),
    ("@example.com", False),
    ("user@domain", False),
    ("", False),
])
def test_email_validation(email, expected):
    assert is_valid_email(email) == expected

# pytest.param gives cases readable IDs
@pytest.mark.parametrize("value,expected", [
    pytest.param(1, True, id="positive"),
    pytest.param(0, False, id="zero"),
    pytest.param(-1, False, id="negative"),
])
def test_is_positive(value, expected):
    assert (value > 0) == expected
```

## Mocking

### Mock with Side Effects (retry behavior)

```python
from unittest.mock import Mock

def test_retries_on_transient_error():
    """Fail twice, then succeed."""
    client = Mock()
    client.request.side_effect = [
        ConnectionError("Failed"),
        ConnectionError("Failed"),
        {"status": "ok"},
    ]

    service = ServiceWithRetry(client, max_retries=3)
    result = service.fetch()

    assert result == {"status": "ok"}
    assert client.request.call_count == 3
```

### Patch External Calls

```python
from unittest.mock import Mock, patch

def test_get_user_success():
    """Test an API call without touching the network."""
    client = APIClient("https://api.example.com")

    mock_response = Mock()
    mock_response.json.return_value = {"id": 1, "name": "John Doe"}
    mock_response.raise_for_status.return_value = None

    with patch("requests.get", return_value=mock_response) as mock_get:
        user = client.get_user(1)
        assert user["id"] == 1
        mock_get.assert_called_once_with("https://api.example.com/users/1")
```

### Mock Time with freezegun

```python
from freezegun import freeze_time
from datetime import datetime

@freeze_time("2026-01-15 10:00:00")
def test_token_expiry():
    """Test token expires at the correct time."""
    token = create_token(expires_in_seconds=3600)
    assert token.expires_at == datetime(2026, 1, 15, 11, 0, 0)

def test_with_time_travel():
    """Move forward within a test."""
    with freeze_time("2026-01-01") as frozen_time:
        item = create_item()
        assert item.created_at == datetime(2026, 1, 1)
        frozen_time.move_to("2026-01-15")
        assert item.age_days == 14
```

## Test Organization and Naming

```text
tests/
  conftest.py           # Shared fixtures
  test_unit/
    test_models.py
    test_utils.py
  test_integration/
    test_api.py
  test_e2e/
    test_workflows.py
```

Name tests after the behavior they verify: `test_<unit>_<scenario>_<expected_outcome>`.

```python
def test_create_user_with_duplicate_email_raises_conflict():
    ...

def test_get_user_with_unknown_id_returns_none():
    ...

# Avoid: test_1(), test_user(), test_function()
```

## Test Markers

```python
import pytest

@pytest.mark.slow
def test_slow_operation():
    ...

@pytest.mark.integration
def test_database_integration():
    ...

@pytest.mark.skipif(os.name == "nt", reason="Unix only")
def test_unix_specific():
    ...

# Run with:
# pytest -m slow          # Only slow tests
# pytest -m "not slow"    # Skip slow tests
# pytest -m integration   # Integration tests only
```

## Coverage Reporting

```bash
pip install pytest-cov

pytest --cov=myapp tests/                            # Run with coverage
pytest --cov=myapp --cov-report=html tests/          # HTML report
pytest --cov=myapp --cov-fail-under=80 tests/        # Enforce a threshold
pytest --cov=myapp --cov-report=term-missing tests/  # Show missing lines
```

## One Behavior Per Test

Each test verifies exactly one behavior, so failures are easy to diagnose.

```python
# Bad: multiple behaviors in one test
def test_user_service():
    user = service.create_user(data)
    assert user.id is not None
    updated = service.update_user(user.id, {"name": "New"})
    assert updated.name == "New"

# Good: focused tests
def test_create_user_assigns_id():
    user = service.create_user(data)
    assert user.id is not None

def test_update_user_changes_name():
    user = service.create_user(data)
    updated = service.update_user(user.id, {"name": "New"})
    assert updated.name == "New"
```

---

Adapted from [wshobson/agents](https://github.com/wshobson/agents) at commit `156b7a5` (MIT, Copyright (c) 2024 Seth Hobson).
