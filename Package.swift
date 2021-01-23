// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "RememberifyDbLib",
    products: [
        .library(name: "RememberifyDbLib", targets: ["RememberifyDbLib"]),
        .executable(name: "RememberifyDbApp", targets: ["RememberifyDbApp"])
    ],
    dependencies: [
        .package(url: "https://github.com/belozierov/SwiftCoroutine", from: "2.1.9")
    ],
    targets: [
        .target(
            name: "RememberifyDbLib",
            dependencies: ["SwiftCoroutine"],
            path: "Sources/RememberifyDbLib"),
        .target(
            name: "RememberifyDbApp",
            dependencies: ["RememberifyDbLib", "SwiftCoroutine"],
            path: "Sources/RememberifyDbApp"),
        .testTarget(
            name: "RememberifyDbTests",
            dependencies: ["RememberifyDbLib"],
            path: "Tests")
    ]
)
