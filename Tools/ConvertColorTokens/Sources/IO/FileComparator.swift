//
//  FileComparator.swift
//  ConvertColorTokens
//
//  Created by LCH on 10/24/25.
//

import Foundation

struct FileComparator {
  static func isContentSame(at path: String, newContent: String) -> Bool {
    guard let existing = try? String(contentsOfFile: path, encoding: .utf8) else { return false }
    return excludeFirstLines(existing, count: 1) == excludeFirstLines(newContent, count: 1)
  }
  
  private static func excludeFirstLines(_ text: String, count: Int) -> String {
    text.split(separator: "\n", maxSplits: count).dropFirst(count).joined(separator: "\n")
  }
}
