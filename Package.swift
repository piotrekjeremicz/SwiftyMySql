// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyMySql",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "SwiftyMySql",
            targets: ["SwiftyMySql"]),
    ],
    targets: [
        .target(
            name: "SwiftyMySql",
            resources: [
                .process("Query.php")
            ]),
    ]
)
