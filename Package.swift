// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "KituraManager",
    products: [
        .library(name: "KitruaManager", targets: ["KituraManager"])
    ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.0.0")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.1")),
        .package(url: "https://github.com/Zewo/Reflection.git", .upToNextMinor(from: "0.15.0"))
    ],
    targets: [
        .target(name: "KituraManager", dependencies: [
            "Kitura", "Reflection"
        ]),
        .testTarget(name: "KituraManagerTests", dependencies: [ 
            "KituraManager","Kitura", "Reflection"
        ])
    ]
)
