import Score
import ScoreLucide

/// A minimal Score application.
@main
struct MinimalApp: Application {

    var theme: (any Theme)? { AppTheme() }

    var metadata: (any Metadata)? {
        SiteMetadata(
            site: "Score App",
            title: "Home",
            description: "A minimal Score application template."
        )
    }

    var plugins: [any ScorePlugin] {
        [LucidePlugin()]
    }

    @PageBuilder
    var pages: [any Page] {
        HomePage()
    }

    var controllers: [any Controller] {
        [ItemsController()]
    }

    var robotsRules: [String] {
        ["Crawl-delay: 1"]
    }
}
