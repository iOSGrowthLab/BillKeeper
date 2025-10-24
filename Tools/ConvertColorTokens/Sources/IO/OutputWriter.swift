//
//  OutputWriter.swift
//  ConvertColorTokens
//
//  Created by LCH on 10/24/25.
//

import Foundation

struct OutputWriter {
  static func write(_ content: String, to path: String) throws {
    try content.write(toFile: path, atomically: true, encoding: .utf8)
  }
}
