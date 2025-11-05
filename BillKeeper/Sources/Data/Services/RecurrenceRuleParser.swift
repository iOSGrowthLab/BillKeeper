//
//  RecurrenceRuleParser.swift
//  BillKeeper
//
//  Created by LCH on 10/28/25.
//

import Foundation
import RWMRecurrenceRule

final class RecurrenceRuleParser: RecurrenceRuleParserProtocol {
  private static let utcCalendar: Calendar = {
    guard let timeZone = TimeZone(identifier: "UTC") else {
      fatalError("UTC TimeZone is Unavailable")
    }
    var calender = Calendar(identifier: .gregorian)
    calender.timeZone = timeZone
    return calender
  }()

  private static let utcDataFormatter: DateFormatter = {
    guard let timeZone = TimeZone(identifier: "UTC") else {
      fatalError("UTC TimeZone is Unavailable")
    }
    let formatter = DateFormatter()
    formatter.timeZone = timeZone
    formatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
    return formatter
  }()

  func generateOccurrences(for rule: RecurringCase, startDate: Date, endDate: Date) -> [Date] {
    let utcCalendar = Self.utcCalendar
    var occurrences = [Date]()

    let normalizedStartDate = utcCalendar.startOfDay(for: startDate)
    guard let normalizedEndDate = utcCalendar.date(byAdding: .day, value: -1, to: endDate) else { return [] }

    let ruleString = generateRrule(rule: rule, startDate: normalizedStartDate, until: normalizedEndDate)

    guard let rules = RWMRuleParser().parse(rule: ruleString) else { return [] }

    let scheduler = RWMRuleScheduler()
    scheduler.enumerateDates(with: rules, startingFrom: normalizedStartDate) { date, _ in
      guard let date else { return }
      if date > normalizedStartDate, date < normalizedEndDate {
        occurrences.append(date)
      }
    }
    return occurrences
  }

  private func generateRrule(rule: RecurringCase, startDate: Date, until endDate: Date) -> String {
    let formatter = Self.utcDataFormatter
    var components: [String] = []

    components.append("FREQ=\(rule.frequency)")

    if let interval = rule.intervalSpec {
      components.append("INTERVAL=\(interval)")
    }

    if case .monthly = rule {
      let calendar = Calendar(identifier: .gregorian)
      let day = calendar.component(.day, from: startDate)
      components.append("BYMONTHDAY=\(day)")
    }

    components.append("UNTIL=\(formatter.string(from: endDate))")

    return "RRULE:" + components.joined(separator: ";")
  }
}

private extension RecurringCase {
  var frequency: String {
    switch self {
      case .daily, .weekdays, .weekends:
        return "DAILY"
      case .weekly, .biWeekly:
        return "WEEKLY"
      case .monthly, .quarterly, .semiAnnually:
        return "MONTHLY"
      case .yearly:
        return "YEARLY"
    }
  }

  var intervalSpec: Int? {
    switch self {
      case .daily, .weekly, .monthly, .yearly:
        return 1
      case .biWeekly:
        return 2
      case .quarterly:
        return 3
      case .semiAnnually:
        return 6
      default:
        return nil
    }
  }

  var byDaySpec: String? {
    switch self {
      case .weekdays:
        return "MO,TU,WE,TH,FR"
      case .weekends:
        return "SA,SU"
      default:
        return nil
    }
  }
}
