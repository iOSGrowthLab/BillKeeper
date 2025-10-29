//
//  RecurringDataEntity.swift
//  BillKeeper
//
//  Created by LCH on 10/27/25.
//
//

import CoreData

@objc(RecurringData)
final class RecurringDataEntity: NSManagedObject {
  @NSManaged var amount: Int64
  @NSManaged var content: String
  @NSManaged var createdAt: Date
  @NSManaged var date: Date
  @NSManaged var id: UUID
  @NSManaged var type: String
  @NSManaged var updatedAt: Date
  @NSManaged var category: CategoryEntity?
  @NSManaged var paymentMethod: PaymentMethodEntity?
  @NSManaged var transaction: TransactionEntity?
}
