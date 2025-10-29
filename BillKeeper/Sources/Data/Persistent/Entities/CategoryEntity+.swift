//
//  CategoryEntity+.swift
//  BillKeeper
//
//  Created by LCH on 10/27/25.
//
//

import CoreData

extension CategoryEntity {
  @nonobjc class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
    return NSFetchRequest<CategoryEntity>(entityName: "Category")
  }
}

extension CategoryEntity {
  @objc(addRecurringDataObject:)
  @NSManaged func addToRecurringData(_ value: RecurringDataEntity)
  
  @objc(removeRecurringDataObject:)
  @NSManaged func removeFromRecurringData(_ value: RecurringDataEntity)
  
  @objc(addRecurringData:)
  @NSManaged func addToRecurringData(_ values: NSSet)
  
  @objc(removeRecurringData:)
  @NSManaged func removeFromRecurringData(_ values: NSSet)
}

extension CategoryEntity {
  @objc(addTransactionsObject:)
  @NSManaged func addToTransactions(_ value: TransactionEntity)
  
  @objc(removeTransactionsObject:)
  @NSManaged func removeFromTransactions(_ value: TransactionEntity)
  
  @objc(addTransactions:)
  @NSManaged func addToTransactions(_ values: NSSet)
  
  @objc(removeTransactions:)
  @NSManaged func removeFromTransactions(_ values: NSSet)
}
