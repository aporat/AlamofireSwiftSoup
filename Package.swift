// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "AlamofireSwiftSoup",
    platforms: [
        .iOS(.v16),
        .tvOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "AlamofireSwiftSoup",
            targets: ["AlamofireSwiftSoup"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup", from: "2.7.0"),
    ],
    targets: [
        .target(
            name: "AlamofireSwiftSoup",
            dependencies: ["Alamofire", "SwiftSoup"],
            path: "Source"
        ),
        .testTarget(
            name: "AlamofireSwiftSoupTests",
            dependencies: ["AlamofireSwiftSoup"],
            path: "Tests"
        ),
    ]
)
