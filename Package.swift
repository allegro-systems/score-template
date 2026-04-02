// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "ScoreMinimal",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(path: "../score"),
        .package(path: "../plugins/score-lucide"),
    ],
    targets: [
        .executableTarget(
            name: "ScoreMinimal",
            dependencies: [
                .product(name: "Score", package: "score"),
                .product(name: "ScoreLucide", package: "score-lucide"),
            ],
            path: "Sources"
        )
    ]
)
