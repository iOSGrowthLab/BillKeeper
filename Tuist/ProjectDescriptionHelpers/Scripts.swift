import ProjectDescription

public enum BuildScripts {
  public static let swiftLint = TargetScript.pre(
    script: """
    export MISE_SHIMS="$HOME/.local/share/mise/shims"
    export MISE_SWIFTLINT="$HOME/.local/share/mise/installs/swiftlint/0.62.1"
    export PATH="$MISE_SHIMS:$MISE_SWIFTLINT:$PATH"
    echo "< SwiftLint check running >"
    swiftlint lint --reporter xcode --config ${SRCROOT}/.swiftlint.yml || true
    """,
    name: "SwiftLint",
    basedOnDependencyAnalysis: false
  )
  public static let swiftFormat = TargetScript.pre(
    script: """
    export MISE_SHIMS="$HOME/.local/share/mise/shims"
    export MISE_SWIFTLINT="$HOME/.local/share/mise/installs/swiftlint/0.62.1"
    export PATH="$MISE_SHIMS:$MISE_SWIFTLINT:$PATH"
    echo "< SwiftFormat check running >"
    swiftformat ${SRCROOT} --swiftversion 6.1.2 --quiet || true
    """,
    name: "SwiftFormat",
    basedOnDependencyAnalysis: false
  )
  public static let convertColorTokens = TargetScript.pre(
    script: """
    env SDKROOT=$(xcrun --sdk macosx --show-sdk-path) \
    swift run --package-path Tools/ConvertColorTokens ConvertColorTokens \
    ${SRCROOT}/Tools/color-tokens.json \
    ${SRCROOT}/BillKeeper/Sources/Shared/Constants/ColorTokens.swift || true
    """,
    name: "ConvertColorTokens",
    basedOnDependencyAnalysis: false
  )
}
