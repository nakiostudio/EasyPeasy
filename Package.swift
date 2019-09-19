// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "EasyPeasy",
    platforms: [
        .iOS(.v8),
        .macOS(.v10_10),
        .tvOS(.v9)
    ],
    products: [
        .library(name: "EasyPeasy", targets: ["EasyPeasy"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "EasyPeasy",
            dependencies: [],
            path: "EasyPeasy"
        )
    ]
)
