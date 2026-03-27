import Foundation
import Score

/// A minimal Score application demonstrating:
/// - 1 page with animations and intersection observer
/// - 1 reactive component with state
/// - 1 controller route (API endpoint)
/// - Localization via Xcode String Catalog
/// - Environment variable access via fnox or .env
@main
struct MinimalApp: Application {
    var theme: (any Theme)? { nil }

    /// App name loaded from the environment (set via fnox.toml or .env).
    /// Falls back to "Score App" when the variable is not set.
    static let appName = ProcessInfo.processInfo.environment["APP_NAME"] ?? "Score App"

    // swiftlint:disable:next force_try
    private static let _localization: Localization? = try! Localization(
        catalog: StringCatalog.load(from: "Localizable.xcstrings")
    )

    var localization: Localization? { Self._localization }

    @PageBuilder
    var pages: [any Page] {
        HomePage()
    }

    var controllers: [any Controller] {
        [APIController()]
    }
}
