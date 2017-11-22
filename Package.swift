// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KituraManager",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "KituraManager",
            targets: ["KituraManager"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.0.0")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.1")),
        .package(url: "https://github.com/Zewo/Reflection.git", .upToNextMinor(from: "0.15.0")),
        .package(url: "https://github.com/IBM-Swift/Swift-Kuery.git", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/IBM-Swift/CLibpq.git", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/IBM-Swift/Swift-Kuery-PostgreSQL.git", .upToNextMinor(from: "1.0.0"))
//        .package(url: "https://github.com/IBM-Swift-Sunset/Swift-Kuery-SQLite.git", .upToNextMinor(from: "0.8.0")),
//        .package(url: "https://github.com/IBM-Swift/SwiftKueryMySQL.git", .upToNextMinor(from: "1.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "KituraManager",
            dependencies: ["Kitura",  "Reflection", "HeliumLogger", "SwiftKuery", "SwiftKueryPostgreSQL"]), // , "SwiftKuerySQLite", "SwiftKueryMySQL"
        .testTarget(
            name: "KituraManagerTests",
            dependencies: ["KituraManager", "Kitura", "Reflection", "HeliumLogger", "SwiftKuery", "SwiftKueryPostgreSQL"]), // , "SwiftKuerySQLite", "SwiftKueryMySQL"
    ]
)
