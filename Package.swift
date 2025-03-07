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
    targets: [
        .target(
            name: "Melatonin",
            path: "Sources"
        ),
        .testTarget(
            name: "MelatoninTests",
            dependencies: ["Melatonin"],
            path: "Tests"
        )
    ]
)
