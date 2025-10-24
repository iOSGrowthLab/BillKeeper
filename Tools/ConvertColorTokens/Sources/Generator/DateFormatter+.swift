//
//  DateFormatter+KR.swift
//  ConvertColorTokens
//
//  Created by LCH on 10/24/25.
//

import Foundation

extension DateFormatter {
  static var krDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    formatter.dateFormat = "MM/dd/yy"
    return formatter
  }
}
