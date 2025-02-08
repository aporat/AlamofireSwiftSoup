// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlamofireSwiftSoup",
    platforms: [
        .iOS(.v15),
        .tvOS(.v13),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "AlamofireSwiftSoup",
            targets: ["AlamofireSwiftSoup"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.0.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup", from: "2.0.0")

    ],
    targets: [
        .target(
            name: "AlamofireSwiftSoup",
            dependencies: ["Alamofire", "SwiftSoup"],
            path: "AlamofireSwiftSoup"
        ),
        .testTarget(
            name: "AlamofireSwiftSoupTests",
            dependencies: ["AlamofireSwiftSoup"]
        )
    ]
)
