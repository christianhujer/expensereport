// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "ExpenseReport",
    products: [
        .library(
            name: "ExpenseReport",
            targets: ["ExpenseReport"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ExpenseReport",
            dependencies: []),
        .testTarget(
            name: "ExpenseReportTests",
            dependencies: ["ExpenseReport"]),
    ]
)
