# ConvertColorTokens

Swift 기반으로 작성되어 있으며, Figma에서 추출된 색상(Color) 토큰 JSON을 Swift 코드로 변환하는 도구입니다.

---

## 기능 요약

* 색상 디자인 토큰(JSON)을 Swift 코드로 자동 변환
* 기존 파일과 동일한 경우 불필요한 덮어쓰기 방지
* CLI(Command Line Interface) 형태로 실행
* Tuist 통합 가능

---

## 사용 방법

### 1. 명령어 구조

`ConvertColorTokens <input.json> <output.swift>`

| 인자 | 설명 |
| :--- | :--- |
| `input.json` | 색상 토큰 JSON 파일 경로 |
| `output.swift` | 변환된 Swift 코드 파일 경로 |

### 2. 실행 예시

```bash
  swift run --package-path Tools/ConvertColorTokens ConvertColorTokens \
  Tools/color-tokens.json \
  Tools/ColorTokens.swift
```

**실행 후 로그 예시:**

```
✅ Updated ColorTokens.swift at Tools/ColorTokens.swift
```

**내용이 동일해 갱신이 불필요한 경우:**

```
✅ No changes in ColorTokens.swift — skipped rewrite.
```

---

## Tuist 통합 (선택 사항)

아래 예시는 빌드 과정에서 자동으로 Swift 색상 코드 생성을 수행하도록 설정하는 방법입니다.

```swift
.pre(
  script: """
  env SDKROOT=$(xcrun --sdk macosx --show-sdk-path) \
  swift run --package-path Tools/ConvertColorTokens ConvertColorTokens \
  ${SRCROOT}/Tools/color-tokens.json \
  ${SRCROOT}/BillKeeper/Sources/Shared/Constants/ColorTokens.swift || true
  """,
  name: "ConvertColorTokens"
)
```

---

## 프로젝트 구조

```
ConvertColorTokens
├── Package.swift
├── README.md
└── Sources
    ├── Core
    │   ├── DesignTokenError.swift
    │   ├── DesignTokenKey.swift
    │   └── DesignTokenLoader.swift
    ├── Generator
    │   ├── CodeGenerator.swift
    │   ├── DateFormatter+.swift
    │   └── String+.swift
    ├── IO
    │   ├── Console.swift
    │   ├── FileComparator.swift
    │   └── OutputWriter.swift
    └── main.swift
```

## 주의사항
생성된 Swift 코드는 아래의 UIColor extension이 구현되어 있어야 정상적으로 작동합니다.

```swift
extension UIColor {
  convenience init?(hex: String) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    guard [6, 8].contains(hexSanitized.count) else { return nil }
    let hasAlpha = hexSanitized.count == 8
    
    guard let rgba = UInt32(hexSanitized, radix: 16) else { return nil }
    
    let divisor = CGFloat(255)
    let red, green, blue, alpha: CGFloat
    if hasAlpha {
      red = CGFloat((rgba & 0xFF00_0000) >> 24) / divisor
      green = CGFloat((rgba & 0x00FF_0000) >> 16) / divisor
      blue = CGFloat((rgba & 0x0000_FF00) >> 8) / divisor
      alpha = CGFloat(rgba & 0x0000_00FF) / divisor
    } else {
      red = CGFloat((rgba & 0xFF0000) >> 16) / divisor
      green = CGFloat((rgba & 0x00FF00) >> 8) / divisor
      blue = CGFloat(rgba & 0x0000FF) / divisor
      alpha = CGFloat(1.0)
    }
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
```
