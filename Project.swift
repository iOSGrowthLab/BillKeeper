import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: "BillKeeper",
  options: .options(
    automaticSchemesOptions: .disabled,
    defaultKnownRegions: ["ko"],
    developmentRegion: "ko",
    textSettings: .textSettings(usesTabs: false, indentWidth: 2, tabWidth: 2)
  ),
  targets: [
    .target(
      name: "BillKeeper",
      destinations: .iOS,
      product: .app,
      bundleId: "com.iOSGrowthLab.BillKeeper",
      deploymentTargets: .iOS("17.6"),
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [:]
        ]
      ),
      sources: ["BillKeeper/Sources/**"],
      resources: ["BillKeeper/Resources/**"],
      dependencies: [],
      settings: .settings(
        base: [
          "SWIFT_VERSION": "5.0",
          "SUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD": "NO",
          "TARGETED_DEVICE_FAMILY": "1",
          "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": "NO"
        ]
      )
    ),
    .target(
      name: "BillKeeperTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "com.iOSGrowthLab.BillKeeperTests",
      infoPlist: .default,
      sources: ["BillKeeper/Tests/**"],
      resources: [],
      dependencies: [.target(name: "BillKeeper")]
    )
  ],
  schemes: [
    .scheme(
      name: "BillKeeperDebug",
      shared: true,
      buildAction: .buildAction(targets: ["BillKeeper"]),
      runAction: .runAction(
        configuration: .debug,
        attachDebugger: true,
        executable: "BillKeeper"
      ),
      archiveAction: .archiveAction(
        configuration: .release
      ),
      profileAction: .profileAction(
        configuration: .release,
        executable: "BillKeeper"
      ),
      analyzeAction: .analyzeAction(
        configuration: .debug
      )
    ),
    .scheme(
      name: "BillKeeperRelease",
      shared: true,
      buildAction: .buildAction(
        targets: ["BillKeeper"]
      ),
      runAction: .runAction(
        configuration: .release,
        attachDebugger: true,
        executable: "BillKeeper"
      ),
      archiveAction: .archiveAction(
        configuration: .release,
        revealArchiveInOrganizer: true
      ),
      profileAction: .profileAction(
        configuration: .release,
        executable: "BillKeeper"
      ),
      analyzeAction: .analyzeAction(
        configuration: .release
      )
    )
  ]
)
