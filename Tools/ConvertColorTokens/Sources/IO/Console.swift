//
//  Console.swift
//  ConvertColorTokens
//
//  Created by LCH on 10/24/25.
//

import Foundation

enum Console {
  static func exitWithError(_ message: String) -> Never {
    fputs("❌ Error: \(message)\n", stderr)
    exit(1)
  }
  
  static func exitWithComplete(_ message: String) -> Never {
    fputs("✅ Completed: \(message)\n", stderr)
    exit(0)
  }
}
