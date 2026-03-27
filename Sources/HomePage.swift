import Score

struct HomePage: Page {
    static let path = "/"

    var body: some Node {
        Stack {
            // Hero with entrance animation
            Section {
                Heading(.one) { Localized("home.title") }
                    .font(.sans, size: 48, weight: .bold, color: .text, align: .center)
                    .animate(.fadeIn, duration: 0.6)

                Paragraph { Localized("home.subtitle") }
                    .font(.mono, size: 14, color: .muted, align: .center)
                    .animate(.fadeIn, duration: 0.6, delay: 0.2)
            }
            .flex(.column, gap: 16, align: .center)
            .padding(80, at: .vertical)

            // Interactive counter component
            Section {
                Heading(.two) { Localized("home.counter.title") }
                    .font(.sans, size: 24, weight: .semibold, color: .text)
                    .animateOnScroll(.slideUp)

                Counter()
            }
            .flex(.column, gap: 24, align: .center)
            .padding(40, at: .vertical)

            // Feature cards with scroll animation
            Section {
                Heading(.two) { Localized("home.features.title") }
                    .font(.sans, size: 24, weight: .semibold, color: .text, align: .center)
                    .animateOnScroll(.fadeIn)

                Stack {
                    FeatureItem(title: t("home.features.pages"), description: t("home.features.pages.desc"))
                    FeatureItem(title: t("home.features.components"), description: t("home.features.components.desc"))
                    FeatureItem(title: t("home.features.routes"), description: t("home.features.routes.desc"))
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
