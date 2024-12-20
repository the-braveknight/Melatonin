// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Melatonin",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "Melatonin",
            targets: ["Melatonin"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-http-types.git",
            from: "1.3.0"
        )
    ],
    targets: [
        .target(
            name: "Melatonin",
            dependencies: [
                .product(name: "HTTPTypes", package: "swift-http-types"),
            ],
            path: "Sources"
        ),
    ]
)
