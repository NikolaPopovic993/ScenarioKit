// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "ScenarioKit",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(
      name: "ScenarioKit",
      targets: ["ScenarioKit"]
    )
  ],
  targets: [
    .target(name: "ScenarioKit"),
  ]
)
