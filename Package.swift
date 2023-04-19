// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MM-PoEditor-Parser",
    products: [
        .executable(
            name: "poe",
            targets: ["MM-PoEditor-Parser"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/Commander", .upToNextMajor(from: "0.9.1")),
        .package(url: "https://github.com/onevcat/Rainbow", .upToNextMajor(from: "3.1.5")),
    ],
    targets: [
        .executableTarget(
            name: "MM-PoEditor-Parser",
            dependencies: ["Commander", "Rainbow"]
        ),
    ]
)
