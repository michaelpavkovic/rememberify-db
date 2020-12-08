// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "rememberify-db",
    products: [

    ],
    dependencies: [
        .package(url: "https://github.com/belozierov/SwiftCoroutine", from: "2.1.9")
    ],
    targets: [
        .target(
            name: "rememberify-db",
            dependencies: ["SwiftCoroutine"],
            path: ".")
    ]
)
