// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AudioKitMod",
    platforms: [
        .macOS(.v10_15), .iOS(.v12), .tvOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AudioKitMod",
            targets: ["AudioKitMod"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "TPCircularBuffer"),
        .target(name: "STK"),
        .target(name: "soundpipe", cSettings: [.define("NO_LIBSNDFILE")]),
        .target(
            name: "sporth",
            dependencies: ["soundpipe"],
            cSettings: [.define("NO_LIBSNDFILE")]),
        .target(
            name: "CAudioKit",
            dependencies: ["TPCircularBuffer", "STK", "soundpipe", "sporth"],
            cxxSettings: [
                .headerSearchPath("CoreAudio"),
                .headerSearchPath("AudioKitCore/Common"),
                .headerSearchPath("Devoloop/include"),
                .headerSearchPath(".")
            ]
        ),
        .target(
            name: "AudioKitMod",
            dependencies: []),
        .target(
            name: "AudioKit",
            dependencies: ["CAudioKit"])
    ],
    cxxLanguageStandard: .cxx14
)
