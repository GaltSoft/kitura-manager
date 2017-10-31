// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "App",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.0.0")),
        .package(url: "https://github.com/Zewo/Reflection.git", .upToNextMinor(from: "0.15.0"))
    ],
    targets: [
        .target(name: "KituraManager", dependencies: [
            "Kitura", "Reflection"
        ]),
        .target(name: "Demo", dependencies: [
            .target(name: "KituraManager")
        ]),

        .testTarget(name: "KituraManagerTests", dependencies: [
            .target(name: "KituraManager")
        ])
    ]
)
