import Score

/// A minimal Score application demonstrating:
/// - 1 page with animations and intersection observer
/// - 1 reactive component with state
/// - 1 controller route (API endpoint)
@main
struct MinimalApp: Application {
    var theme: (any Theme)? { nil }

    @PageBuilder
    var pages: [any Page] {
        HomePage()
    }

    var controllers: [any Controller] {
        [APIController()]
    }
}
