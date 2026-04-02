# Score App

A web application built with the [Score](https://github.com/allegro-systems/score) framework — a hybrid-rendered Swift web framework with reactive signals for client-side interactivity.

## Score Conventions

### Modifier Naming

Every modifier follows a **one modifier per CSS concept** rule:

```swift
.flex(.row, gap: 12)           // flex container
.flex(grow: 1)                 // flex item (same name, different params)
.grid(columns: 3, gap: 16)    // grid container
.grid(column: .span(2))       // grid item
.font(.sans, size: 14)        // all typography in one modifier
.border(width: 1, color: .border, style: .solid)
.size(width: 200, height: 100)
.border(radius: 8)
```

- **One modifier per concept** — never create `.flexItem()`, `.fontSize()`, etc.
- **Use `horizontal`/`vertical`** — never `x`/`y` for axis parameters.

### Never Use Inline JS or CSS

```swift
// FORBIDDEN:
.htmlAttribute("style", "...")
.htmlAttribute("onclick", "...")
RawTextNode("<style>...</style>")
```

Use Score modifiers for styling. Use `@State`/`@Action` for interactivity:

```swift
@Component
struct Counter {
    @State var count = 0
    @Action mutating func increment() { count += 1 }

    var body: some Node {
        Button { "+" }.on(.click, action: "increment")
        Text { $count }.font(size: 16)
    }
}
```

`RawTextNode("<script>...")` is only acceptable when marked with `// SCORE-GAP:` for features the framework doesn't support yet.

### Components

All components must be `UpperCamelCase` `@Component struct` definitions. Never create lowercase helper functions that return `some Node`.

## Localization

Score apps use **Xcode String Catalogs** (`.xcstrings`) for internationalization. This is the standard approach for all Score apps.

### Setup

Every Score app should have:
1. A `Localizable.xcstrings` file at the project root (JSON format, `sourceLanguage: "en"`)
2. A `localization` property in `App.swift` that loads it:

### Using Translations

Pattern for accessing translated strings:

```swift
FeatureItem(title: t("features.pages"), description: t("features.pages.desc"))
SiteButton(title: t("nav.get_started"), link: "/docs")
```

### Key Naming Convention

Use dot-separated keys organized by page/component and element:

```
home.title                    # Page-level heading
home.subtitle                 # Page-level description
home.features.title           # Section heading
home.features.pages           # Feature name
home.features.pages.desc      # Feature description
nav.about                     # Navigation label
ui.learn_more                 # Shared UI string
error.404.title               # Error page title
```

### Locale Routing

- **Default locale** (e.g. `en`): pages render at root — `/`, `/about`, `/docs`
- **Other locales**: pages render with prefix — `/fr/`, `/fr/about`, `/es/docs`
- The `<html lang="...">` attribute is set automatically per locale.

### Language Switcher

If using `allegro-theme`, drop in `LanguageDropdown()` — it reads supported locales from the string catalog automatically via `SiteLocale.displayName` (which returns the language's native name, e.g. "Français", "Deutsch").

### Adding a New Language

1. Add translations to `Localizable.xcstrings` under a new locale key (e.g. `"fr"`)
2. The routing, dropdown, and `<html lang>` all pick it up automatically — no code changes needed

### Adding a New String

1. Add the key to `Localizable.xcstrings` with translations for all supported locales
2. Use `t("key")` in your component

### xcstrings Format

```json
{
  "sourceLanguage": "en",
  "strings": {
    "home.title": {
      "localizations": {
        "en": {
          "stringUnit": {
            "state": "translated",
            "value": "My App"
          }
        },
        "es": {
          "stringUnit": {
            "state": "translated",
            "value": "Mi Aplicación"
          }
        }
      }
    }
  },
  "version": "1.0"
}
```

## Development

```bash
mise run dev    # Dev server with hot reload
mise run build  # Production build
swift build     # Compile only
```

## Tooling

This project uses three recommended tools, all managed by mise:

- **[mise](https://mise.jdx.dev/)** — Task runner and version manager. Pins Swift 6.3 and all tools per-project. Run `mise install` to set up, then `mise run dev`, `mise run build`, `mise run format`.
- **[hk](https://hk.jdx.dev/)** — Git hook manager. Runs `swift format` and `swift build` as pre-commit checks. Configured in `hk.pkl`, installed automatically by `mise install`.
- **[fnox](https://fnox.jdx.dev/)** — Secret management using age encryption. Secrets are stored as ciphertext in `fnox.toml` (safe to commit) and loaded into the shell environment via mise. Access in Swift via `ProcessInfo.processInfo.environment["KEY"]`.

### Environment Variables

Secrets and configuration are loaded from `fnox.toml` (or `.env` if the project was created with `--env env`). Example usage in `App.swift`:

```swift
static let appName = ProcessInfo.processInfo.environment["APP_NAME"] ?? "Score App"
```

### Other

- Swift 6.3, `swift format` with shared `.swift-format` config
- Commit messages: `feat:`, `fix:`, `refactor:`, `chore:`, `test:`
