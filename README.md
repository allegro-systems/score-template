# Score Minimal Example

A minimal Score application demonstrating core features:

- **1 Page** — `HomePage` with entrance animations and scroll-triggered reveals
- **1 Component** — `Counter` with `@State`, `@Action`, and reactive text binding
- **1 Route** — `APIController` with `/api/status` and `/api/count` endpoints
- **Animations** — `animate(.fadeIn)` for hero, `animateOnScroll(.slideUp)` for sections
- **Intersection Observer** — Content reveals as you scroll

## Run

```bash
swift run
```

Then open http://localhost:8080 in your browser.

## Build

```bash
swift run ScoreMinimal --build
```

Generates static HTML, CSS, and JS in the output directory.
