//
//  CategoryEntity+.swift
//  BillKeeper
//
//  Created by LCH on 10/27/25.
//
//

import CoreData

extension CategoryEntity {
  // MARK: - Fetch Request
  
  @nonobjc class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
    return NSFetchRequest<CategoryEntity>(entityName: "Category")
  }
  
  // MARK: - Domain Mapping
  
  func toDomain() -> Category {
    return Category(id: id,
                    name: name,
                    isDefault: isDefault)
  }
  
  // MARK: - RecurringData Relationship
  
  @objc(addRecurringDataObject:)
  @NSManaged func addToRecurringData(_ value: RecurringDataEntity)
  
  @objc(removeRecurringDataObject:)
  @NSManaged func removeFromRecurringData(_ value: RecurringDataEntity)
  
  @objc(addRecurringData:)
  @NSManaged func addToRecurringData(_ values: NSSet)
  
  @objc(removeRecurringData:)
  @NSManaged func removeFromRecurringData(_ values: NSSet)
  
  // MARK: - Transactions Relationship
  
  @objc(addTransactionsObject:)
  @NSManaged func addToTransactions(_ value: TransactionEntity)
  
  @objc(removeTransactionsObject:)
  @NSManaged func removeFromTransactions(_ value: TransactionEntity)
  
  @objc(addTransactions:)
  @NSManaged func addToTransactions(_ values: NSSet)
  
  @objc(removeTransactions:)
  @NSManaged func removeFromTransactions(_ values: NSSet)
}
