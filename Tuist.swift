import ProjectDescription

let tuist = Tuist(project: .tuist(
  compatibleXcodeVersions: .exact("16.4"),
  swiftVersion: "6.1.2")
)
