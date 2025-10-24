//
//  main.swift
//  ConvertColorTokens
//
//  Created by LCH on 10/23/25.
//

import Foundation

let args = CommandLine.arguments
guard args.count == 3 else {
  Console.exitWithError("Usage: ConvertDesignTokens <input.json> <output.swift>")
}

let inputPath = args[1]
let outputPath = args[2]

do {
  let tokens = try DesignTokenLoader.load(from: inputPath)
  let generator = CodeGenerator()
  let result = generator.generate(from: tokens)
  
  if FileComparator.isContentSame(at: outputPath, newContent: result) {
    Console.exitWithComplete("No changes in ColorTokens.swift — skipped rewrite.")
  } else {
    try OutputWriter.write(result, to: outputPath)
    Console.exitWithComplete("Updated ColorTokens.swift at \(outputPath)")
  }
} catch {
  Console.exitWithError(error.localizedDescription)
}
