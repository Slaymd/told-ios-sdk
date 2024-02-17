// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "Told",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14),
    ],
    products: [
        .library(
            name: "Told",
            targets: ["ToldSDK"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios.git", exact: "1.1.3"),
    ],
    targets: [
        .target(
            name: "ToldSDK",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios")
            ]
        )
    ]
)
