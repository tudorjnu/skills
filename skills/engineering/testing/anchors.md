# Anchors

An anchor is what a test holds the code to. Choosing one is step 3 of the `testing` skill, after the promise is triaged and the seam is agreed.

## Example

One concrete case with a known-good expected value.

- **Shape**: call the seam with an input, assert a literal, a worked example, or the value the spec states.
- **Buys**: readable, fast, and the default for behaviour someone can describe in a sentence.
- **Costs**: only checks the cases you thought of. A weak example set leaves the input space untested.

Acceptance examples belong at the outermost stable seam, so they survive internal rewrites. Given-when-then phrasing is optional; it helps only when someone reads the criteria.

## Property

A statement that must hold for every valid input, checked against generated cases with shrinking to a minimal counterexample.

- **Shape**: invariants (`sorting twice equals sorting once`, `encode then decode returns the input`), round trips, bounds, algebraic laws.
- **Buys**: input coverage no hand-written example set reaches, and a minimal failing case when it breaks.
- **Costs**: property quality decides everything. A weak property passes forever and proves nothing. Generator setup is real work.

Reach for it where examples cannot cover the space: parsers, serializers, money arithmetic, algorithms, state machines.

## Contract

An agreement between a consumer and a provider, verified from the consumer's side.

- **Shape**: the consumer records what it needs from the provider; the provider's build verifies it still satisfies every recorded expectation.
- **Buys**: catches breaking changes at the boundary without a full integration environment, and tells you which consumer breaks.
- **Costs**: needs tooling and a publish step. Drifts into functional testing when people push whole workflows through it.

Reach for it where two deployables or two teams meet: public APIs, service boundaries, message schemas.

## Recorded reality

Capture what the code does now, before you change it.

- **Shape**: run the code, record the output (text, structured data, rendered markup), commit it as the expected value.
- **Buys**: the only honest starting point for legacy code with no tests and no spec. Also useful for large structured output a hand-written assertion cannot reasonably express.
- **Costs**: it approves bugs as expected behaviour. Blind re-approval after a red run turns it into decoration.

Reach for it before a refactor or a bug fix in untested legacy code, and re-read every approved diff.

## Picking one

- Promise someone can state in a sentence: example.
- Promise about a rule or a range of inputs: property.
- Promise to another deployable or team: contract.
- No promise at all, just current behaviour: recorded reality.
