//
//  TransactionEntity.swift
//  BillKeeper
//
//  Created by LCH on 10/27/25.
//
//

import CoreData

@objc(Transaction)
final class TransactionEntity: NSManagedObject {
  @NSManaged var amount: Int64
  @NSManaged var content: String
  @NSManaged var createdAt: Date
  @NSManaged var date: Date
  @NSManaged var expiredDate: Date?
  @NSManaged var id: UUID
  @NSManaged var installmentMonths: Int16
  @NSManaged var isInstallment: Bool
  @NSManaged var isRecurring: Bool
  @NSManaged var recurringRule: String?
  @NSManaged var type: String
  @NSManaged var updatedAt: Date
  @NSManaged var category: CategoryEntity?
  @NSManaged var paymentMethod: PaymentMethodEntity?
  @NSManaged var recurringData: NSSet?
}
