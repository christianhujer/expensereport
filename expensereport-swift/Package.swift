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
            dependencies: [],
            path: "Sources/ExpenseReport-camelcasing"),
        .testTarget(
            name: "ExpenseReportTests",
            dependencies: ["ExpenseReport"],
            path: "Tests/ExpenseReportTests-camelcasing"),
    ]
)
