//
//  UIColor+Hex.swift
//  BillKeeper
//
//  Created by LCH on 10/23/25.
//

import UIKit

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
