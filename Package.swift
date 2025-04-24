// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MM-PoEditor-Parser",
    platforms: [.iOS(.v16)],
    products: [
        .executable(
            name: "poe",
            targets: ["MM-PoEditor-Parser"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/Commander", .upToNextMajor(from: "0.9.1")),
        .package(url: "https://github.com/onevcat/Rainbow", .upToNextMajor(from: "3.1.5")),
        .package(url: "https://github.com/apple/swift-testing.git", from: "0.99.0")
    ],
    targets: [
        .target(
            name: "MMPoEditor",
            dependencies: ["Commander", "Rainbow"]
        ),
        .executableTarget(
            name: "MM-PoEditor-Parser",
            dependencies: [
                "Commander",
                "Rainbow",
                .target(name: "MMPoEditor"),
            ]
        ),
        .testTarget(
            name: "MMPoEditorTests",
            dependencies: [
                .target(name: "MMPoEditor"),
                .product(name: "Testing", package: "swift-testing")
            ]
        )
    ]
)
