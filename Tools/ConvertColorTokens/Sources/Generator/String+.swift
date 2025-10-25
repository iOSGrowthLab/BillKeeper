//
//  String+.swift
//  ConvertColorTokens
//
//  Created by LCH on 10/23/25.
//

import Foundation

extension String {
  func camelCase() -> String {
    let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
    let parts = trimmed.split(whereSeparator: { $0.isWhitespace })
    let combined = parts.enumerated().map { index, part in
      index == 0 ? part.lowercased() : part.capitalized
    }.joined()
    
    if let first = combined.first, first.isNumber {
      return "_" + combined
    }
    return combined
  }
  
  func capitalizedFirstLetter() -> String {
    prefix(1).uppercased() + dropFirst()
  }
}
