//
//  FontUtility.swift
//  BillKeeper
//
//  Created by LCH on 10/24/25.
//

import UIKit

enum FontUtility {
  enum Weight: String {
    case semiBold = "PretendardVariable-SemiBold"
    case medium = "PretendardVariable-Medium"
    case regular = "PretendardVariable-Regular"
  }

  static func resolveFont(weight: Weight, size: CGFloat) -> UIFont {
    if let font = UIFont(name: weight.rawValue, size: size) {
      return font
    } else {
      switch weight {
        case .semiBold:
          return .systemFont(ofSize: size, weight: .semibold)
        case .medium:
          return .systemFont(ofSize: size, weight: .medium)
        case .regular:
          return .systemFont(ofSize: size, weight: .regular)
      }
    }
  }
}
