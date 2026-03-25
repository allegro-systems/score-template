import Score

struct HomePage: Page {
    static let path = "/"

    var body: some Node {
        Stack {
            // Hero with entrance animation
            Section {
                Heading(.one) { "Score Minimal Example" }
                    .font(.sans, size: 48, weight: .bold, color: .text, align: .center)
                    .animate(.fadeIn, duration: 0.6)

                Paragraph { "A minimal app demonstrating pages, components, routes, and data." }
                    .font(.mono, size: 14, color: .muted, align: .center)
                    .animate(.fadeIn, duration: 0.6, delay: 0.2)
            }
            .flex(.column, gap: 16, align: .center)
            .padding(80, at: .vertical)

            // Interactive counter component
            Section {
                Heading(.two) { "Reactive Counter" }
                    .font(.sans, size: 24, weight: .semibold, color: .text)
                    .animateOnScroll(.slideUp)

                Counter()
            }
            .flex(.column, gap: 24, align: .center)
            .padding(40, at: .vertical)

            // Feature cards with scroll animation
            Section {
                Heading(.two) { "Features" }
                    .font(.sans, size: 24, weight: .semibold, color: .text, align: .center)
                    .animateOnScroll(.fadeIn)

                Stack {
                    FeatureItem(title: "Pages", description: "Declarative pages with result builders")
                    FeatureItem(title: "Components", description: "Reactive components with @State and @Action")
                    FeatureItem(title: "Routes", description: "Type-safe routing with path parameters")
                }
                .grid(columns: 3, gap: 16)
                .animateOnScroll(.slideUp, duration: 0.5)
            }
            .flex(.column, gap: 24, align: .center)
            .padding(40, at: .vertical)
            .padding(20, at: .horizontal)
        }
        .flex(.column)
        .size(maxWidth: 800)
        .padding(20, at: .horizontal)
    }
}
