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
}
