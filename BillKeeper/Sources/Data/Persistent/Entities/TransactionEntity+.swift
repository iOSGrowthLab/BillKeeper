//
//  TransactionEntity+.swift
//  BillKeeper
//
//  Created by LCH on 10/27/25.
//
//

import CoreData

extension TransactionEntity {
  // MARK: - Fetch Request

  @nonobjc class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
    return NSFetchRequest<TransactionEntity>(entityName: "Transaction")
  }

  // MARK: - Domain Mapping

  func toDomain() throws -> Transaction {
    guard let categoryId = category?.id else {
      throw DataError.mappingFailed("Category relationship is missing - Transaction id: \(id)")
    }

    guard let paymentMethodId = paymentMethod?.id else {
      throw DataError.mappingFailed("PaymentMethod relationship is missing - Transaction id: \(id)")
    }

    let recurringEntities = (recurringData as? Set<RecurringDataEntity>) ?? []
    let recurringIds = recurringEntities.map(\.id)

    guard let transactionType = TransactionType(rawValue: type) else {
      throw DataError.mappingFailed("Unknown transaction type \(type) - Transaction id: \(id)")
    }

    if let recurringRule, RecurringCase(rawValue: recurringRule) == nil {
      throw DataError.mappingFailed("Unknown recurring rule \(recurringRule) - Transaction id: \(id)")
    }
    let recurring = recurringRule.flatMap(RecurringCase.init)

    return Transaction(
      id: id,
      categoryId: categoryId,
      paymentMethodId: paymentMethodId,
      recurringIds: recurringIds,
      updatedAt: updatedAt,
      date: date,
      amount: Int(amount),
      content: content,
      transactionType: transactionType,
      isRecurring: isRecurring,
      recurringCase: recurring,
      expiredAt: expiredDate,
      isInstallment: isInstallment,
      installmentMonths: isInstallment ? Int(installmentMonths) : nil
    )
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
}
