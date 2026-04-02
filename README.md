# Score Minimal Example

A minimal Score application demonstrating core features:

- **1 Page** — `HomePage` with entrance animations and scroll-triggered reveals
- **1 Component** — `Counter` with `@State`, `@Action`, and reactive text binding
- **1 Route** — `APIController` with `/api/status` and `/api/count` endpoints
- **Animations** — `animate(.fadeIn)` for hero, `animateOnScroll(.slideUp)` for sections
- **Intersection Observer** — Content reveals as you scroll

## Getting Started

```bash
mise install       # Install pinned tool versions (Swift, hk, fnox)
mise run dev       # Start the dev server with hot reload
```

Then open http://localhost:8080 in your browser.

## Tasks

All tasks are run through mise:

```bash
mise run dev                # Dev server with hot reload (default port 8080)
mise run dev -p 3000        # Dev server on a custom port
mise run build              # Generate static HTML, CSS, JS for production
mise run build -v           # Verbose production build
mise run format             # Format source code
mise run format --check     # Lint without modifying files
mise run clean              # Remove build artifacts
```

## Using Xcode

Open the project in Xcode:

```bash
open Package.swift
```

The repository includes shared Xcode schemes for each mise task: **Dev Server**, **Build**, **Format**, and **Clean**. Select a scheme from the scheme picker in the toolbar, then press **⌘R** to run it. Output appears in the Xcode console, and **⌘.** stops the running task.

> **Note:** The schemes invoke mise through a login shell (`/bin/zsh -lic`), so mise must be installed and available in your shell profile. Run `mise install` from the terminal first.

## Recommended Tooling

This project is configured with three tools that work together to provide a consistent development experience. All three are installed and managed automatically by `mise install`.

### [mise](https://mise.jdx.dev/) — Task Runner & Version Manager

mise pins exact tool versions per-project (Swift 6.3, hk, fnox) and provides task definitions (`mise run dev`, `mise run build`, `mise run format`). When you run `mise install`, every collaborator gets identical tool versions with zero manual setup.

> **Alternative:** Pass `--tasks make` during `score init` to use a Makefile instead. Note that with make, tool versions (Swift, hk, fnox) require manual management.

### [hk](https://hk.jdx.dev/) — Git Hook Manager

hk runs pre-commit checks automatically: `swift format` for linting and `swift build` to catch compile errors before they reach CI. Hooks are defined in `hk.pkl` and installed by `mise install` (via the `postinstall` hook on the hk tool).

> **Alternative:** Pass `--hooks none` during `score init` to skip hook setup entirely.

### [fnox](https://fnox.jdx.dev/) — Secret Management

fnox manages secrets using [age](https://age-encryption.org/) encryption. Ciphertext is stored directly in `fnox.toml` — safe to commit — and decrypted at runtime into environment variables via mise.

The template includes a starter `fnox.toml` with an `APP_NAME` default that is read in `App.swift` via `ProcessInfo.processInfo.environment`.

> **Alternative:** Pass `--env env` during `score init` to use a plain `.env` file instead.

#### fnox Quick Start

```bash
age-keygen -o ~/.config/fnox/key.txt # Generate an age keypair (one-time)
fnox set APP_SECRET "my-secret"      # Encrypt and store a secret
eval "$(fnox activate)"              # Load secrets into your shell
```

Access in Swift via `ProcessInfo.processInfo.environment["APP_SECRET"]`.

See the [fnox docs](https://fnox.jdx.dev/) for additional providers (Infisical, AWS KMS, 1Password, etc.).
