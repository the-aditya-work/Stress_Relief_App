// swift-tools-version: 6.0

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Stress_Relief_App",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Stress_Relief_App",
            targets: ["AppModule"],
            bundleIdentifier: "apple.Stress-Relief-App",
            teamIdentifier: "777RNPN89P",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .twoPeople),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .fileAccess(.musicFolder, mode: .readOnly)
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .copy("Resources/Rain.mp3"),
                .copy("Resources/Bird.mp3"),
                .copy("Resources/Peace Sound.mp3")
            ]
        )
    ],
    swiftLanguageVersions: [.version("6")]
)
