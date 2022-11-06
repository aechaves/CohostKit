// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CohostKit",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CohostKit",
            targets: ["CohostKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMajor(from: "1.6.0")),
        .package(url: "https://github.com/swift-extras/swift-extras-base64.git", branch: "0.7.0"),
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", .upToNextMajor(from: "9.1.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CohostKit",
            dependencies: ["CryptoSwift", .product(name: "ExtrasBase64", package: "swift-extras-base64")]),
        .testTarget(
            name: "CohostKitTests",
            dependencies: ["CohostKit", "OHHTTPStubs", .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs")]),
    ]
)
