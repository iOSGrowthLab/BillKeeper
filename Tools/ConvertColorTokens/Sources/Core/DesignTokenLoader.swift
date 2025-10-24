//
//  DesignTokenLoader.swift
//  ConvertColorTokens
//
//  Created by LCH on 10/24/25.
//

import Foundation

struct DesignTokenLoader {
  static func load(from path: String) throws -> [String: Any] {
    let data = try Data(contentsOf: URL(fileURLWithPath: path))
    guard let decoded = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
      throw DesignTokenError.invalidJSON
    }
    guard let colorDict = decoded[DesignTokenKey.color.rawValue] as? [String: Any] else {
      throw DesignTokenError.missingColorKey
    }
    return colorDict
  }
}
