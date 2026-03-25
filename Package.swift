// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "ScoreMinimal",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(
            name: "Score", url: "https://github.com/allegro-systems/score.git",
            .upToNextMajor(from: ""))
    ],
    targets: [
        .executableTarget(
            name: "ScoreMinimal",
            dependencies: [
                .product(name: "Score", package: "Score")
            ],
            path: "Sources"
        )
    ]
)
