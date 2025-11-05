//
//  RecurrenceRuleParserProtocol.swift
//  BillKeeper
//
//  Created by LCH on 10/25/28.
//

import Foundation

protocol RecurrenceRuleParserProtocol {
  func generateOccurrences(for rule: RecurringCase, startDate: Date, endDate: Date) -> [Date]
}
