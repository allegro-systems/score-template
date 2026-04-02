import Score
import ScoreLucide

@Component
struct LanguageDropdown {
    var pagePath: String

    private var currentLocale: String {
        LocalizationContext.current?.locale.identifier ?? "en"
    }

    private var supportedLocales: [SiteLocale] {
        LocalizationContext.current?.localization.supportedLocales ?? []
    }

    private var defaultLocale: String {
        LocalizationContext.current?.localization.defaultLocale.identifier ?? "en"
    }

    init(pagePath: String) {
        self.pagePath = pagePath
    }

    var body: some Node {
        Stack {
            Stack {
                Icon("globe", size: 16, color: .text)
                Text { currentLocale.uppercased() }
                    .font(.mono, size: 11, weight: .medium, color: .text)
            }
            .flex(.row, gap: 4, align: .center)
            .padding(6, at: .vertical)
            .padding(8, at: .horizontal)
            .background(.elevated)
            .border(width: 1, color: .border, style: .solid, radius: 20)
            .cursor(.pointer)

            Stack {
                Stack {
                    for locale in supportedLocales {
                        let isActive = locale.identifier == currentLocale
                        let href = locale.identifier == defaultLocale ? pagePath : "/\(locale.identifier)\(pagePath)"

                        Link(to: href) {
                            Text { locale.displayName }
                                .font(.mono, size: 13, color: isActive ? .accent : .text)
                        }
                        .font(decoration: TextDecoration.none)
                        .padding(6, at: .vertical)
                        .padding(12, at: .horizontal)
                        .hover { $0.background(.elevated) }
                        .border(radius:4)
                    }
                }
                .flex(.column, gap: 2)
                .padding(4)
                .background(.surface)
                .border(width: 1, color: .border, style: .solid, radius: 8)
                .size(width: 140)
            }
            .position(.absolute, top: 32, trailing: 0)
            .zIndex(50)
            .showOnGroupHover()
        }
        .position(.relative)
        .hoverGroup()
    }
}
