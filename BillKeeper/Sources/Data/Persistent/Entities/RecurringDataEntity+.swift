//
//  RecurringDataEntity+.swift
//  BillKeeper
//
//  Created by LCH on 10/27/25.
//
//

import CoreData

extension RecurringDataEntity {
  // MARK: - Fetch Request

  @nonobjc class func fetchRequest() -> NSFetchRequest<RecurringDataEntity> {
    return NSFetchRequest<RecurringDataEntity>(entityName: "RecurringData")
  }
}
