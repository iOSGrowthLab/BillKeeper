//
//  TransactionEntity+.swift
//  BillKeeper
//
//  Created by LCH on 10/27/25.
//
//

import CoreData

extension TransactionEntity {
  @nonobjc class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
    return NSFetchRequest<TransactionEntity>(entityName: "Transaction")
  }
}

extension TransactionEntity {
  @objc(addRecurringDataObject:)
  @NSManaged func addToRecurringData(_ value: RecurringDataEntity)
  
  @objc(removeRecurringDataObject:)
  @NSManaged func removeFromRecurringData(_ value: RecurringDataEntity)
  
  @objc(addRecurringData:)
  @NSManaged func addToRecurringData(_ values: NSSet)
  
  @objc(removeRecurringData:)
  @NSManaged func removeFromRecurringData(_ values: NSSet)
}
