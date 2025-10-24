//
//  UIFont+.swift
//  BillKeeper
//
//  Created by LCH on 10/23/25.
//

import UIKit

extension UIFont {
  enum Pretendard {
    static let headingL = FontUtility.resolveFont(weight: .semiBold, size: 20)
    static let headingM = FontUtility.resolveFont(weight: .semiBold, size: 18)
    static let headingS = FontUtility.resolveFont(weight: .semiBold, size: 16)
    static let headingXS = FontUtility.resolveFont(weight: .semiBold, size: 24)
    static let subtitleL = FontUtility.resolveFont(weight: .medium, size: 18)
    static let subtitleM = FontUtility.resolveFont(weight: .medium, size: 16)
    static let subtitleS = FontUtility.resolveFont(weight: .medium, size: 14)
    static let bodyL = FontUtility.resolveFont(weight: .regular, size: 16)
    static let bodyM = FontUtility.resolveFont(weight: .regular, size: 14)
    static let bodyS = FontUtility.resolveFont(weight: .regular, size: 14)
    static let bodyXS = FontUtility.resolveFont(weight: .regular, size: 12)
  }
}
