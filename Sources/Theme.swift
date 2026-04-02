import Score

@Theme
struct AppTheme {

    var extraColorRoles: [String: ColorToken] {
        ["elevated": .oklch(0.96, 0.004, 240)]
    }

    var extraFontFamilies: [String: String] {
        ["brand": "'Inter', system-ui, sans-serif"]
    }

    var dark: (any ThemePatch)? { AppDarkPatch() }

    var named: [String: any ThemePatch] {
        ["dark": AppDarkPatch()]
    }
}

struct AppDarkPatch: ThemePatch {
    var colorRoles: [String: ColorToken]? {
        [
            "surface": .oklch(0.17, 0.014, 240),
            "text": .oklch(0.93, 0.004, 240),
            "border": .oklch(0.26, 0.012, 240),
            "elevated": .oklch(0.22, 0.012, 240),
        ]
    }
}
