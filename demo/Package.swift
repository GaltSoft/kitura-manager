// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "demo",
    dependencies: [
        .Package(url: "https://github.com/GaltSoft/kitura-manager.git", majorVersion: 1)
    ]
)
