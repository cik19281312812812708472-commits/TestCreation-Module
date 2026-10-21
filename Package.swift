// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestCreation",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TestCreation",
            targets: ["TestCreation"]
        ),
    ],
    dependencies: [
            .package(url: "https://github.com/google-ai-edge/mediapipe", branch: "master"),
            .package(url: "https://github.com/pvieito/PythonKit", from: "1.0.0")
                
    ],
    
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
    
        .target(
            name: "TestCreation",
            dependencies: [
                // 2. Link the text task product to your target
                .product(name: "MediaPipeTasksText", package: "mediapipe", condition: .when(platforms: [.iOS])),
                .product(name: "PythonKit", package: "PythonKit", condition: .when(platforms: [.macOS])),
          
            ],
            resources: [
                .copy("Resources/python3.12"),
                .copy("Resources/Python.xcframework")
            ]
        ),
        .testTarget(
            name: "TestCreationTests",
            dependencies: ["TestCreation"]
        ),
    ]
)
