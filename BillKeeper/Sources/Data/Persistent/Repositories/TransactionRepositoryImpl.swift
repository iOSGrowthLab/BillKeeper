//
//  TransactionRepositoryImpl.swift
//  BillKeeper
//
//  Created by LCH on 10/27/25.
//

import CoreData

final class TransactionRepositoryImpl: TransactionRepository {
  private let context: NSManagedObjectContext
  private let ruleParser: RecurrenceRuleParserProtocol

  init(context: NSManagedObjectContext, ruleParser: RecurrenceRuleParserProtocol) {
    self.context = context
    self.ruleParser = ruleParser
  }

  func fetchAll() async throws -> [Transaction] {
    try await context.perform {
      let request = TransactionEntity.fetchRequest()
      let entities = try self.context.fetch(request)
      return try entities.reduce(into: [Transaction]()) { partialResult, entity in
        do {
          try partialResult.append(entity.toDomain())
        } catch let DataError.mappingFailed(message) {
          throw RepositoryError.mappingFailed(message)
        } catch {
          throw RepositoryError.storageError("An expected Error occured during fetchAll - \(error)")
        }
      }
    }
  }

  func fetch(by id: UUID) async throws -> Transaction? {
    try await context.perform {
      guard let entity = try self.fetchTransactionEntity(by: id) else {
        return nil
      }
      return try entity.toDomain()
    }
  }

  func fetchByDateRange(from startDate: Date, to endDate: Date) async throws -> [Transaction] {
    try await context.perform {
      let request = TransactionEntity.fetchRequest()
      request.predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as CVarArg, endDate as CVarArg)
      let entities = try self.context.fetch(request)
      return try entities.reduce(into: [Transaction]()) { partialResult, entity in
        do {
          try partialResult.append(entity.toDomain())
        } catch let DataError.mappingFailed(message) {
          throw RepositoryError.mappingFailed(message)
        } catch {
          throw RepositoryError.storageError("An expected Error occured during fetchByDateRange - \(error)")
        }
      }
    }
  }

  func save(_ transaction: Transaction) async throws {
    try await context.perform {
      let categoryEntity = try self.fetchCategoryEntity(by: transaction.categoryId)
      let paymentMethodEntity = try self.fetchPaymentMethodEntity(by: transaction.paymentMethodId)

      let entity = TransactionEntity(context: self.context)
      entity.id = transaction.id
      entity.amount = Int64(transaction.amount)
      entity.content = transaction.content
      entity.createdAt = Date()
      entity.date = transaction.date
      entity.expiredDate = transaction.expiredAt
      entity.isInstallment = transaction.isInstallment
      entity.installmentMonths = Int16(transaction.installmentMonths ?? 0)
      entity.isRecurring = transaction.isRecurring
      entity.recurringRule = transaction.recurringCase?.rawValue
      entity.type = transaction.transactionType.rawValue
      entity.updatedAt = transaction.updatedAt
      entity.category = categoryEntity
      entity.paymentMethod = paymentMethodEntity

      self.generateRecurringData(
        for: transaction,
        to: entity,
        category: categoryEntity,
        paymentMethod: paymentMethodEntity
      )

      try self.context.save()
    }
  }

  func update(_ transaction: Transaction) async throws {
    try await context.perform {
      guard let entity = try self.fetchTransactionEntity(by: transaction.id) else {
        throw RepositoryError.notFound
      }
      let categoryEntity = try self.fetchCategoryEntity(by: transaction.categoryId)
      let paymentMethodEntity = try self.fetchPaymentMethodEntity(by: transaction.paymentMethodId)

      if let existingRecurringData = entity.recurringData as? Set<RecurringDataEntity> {
        for data in existingRecurringData {
          self.context.delete(data)
        }
      }
      entity.recurringData = nil

      entity.amount = Int64(transaction.amount)
      entity.content = transaction.content
      entity.date = transaction.date
      entity.expiredDate = transaction.expiredAt
      entity.isInstallment = transaction.isInstallment
      entity.installmentMonths = Int16(transaction.installmentMonths ?? 0)
      entity.isRecurring = transaction.isRecurring
      entity.recurringRule = transaction.recurringCase?.rawValue
      entity.type = transaction.transactionType.rawValue
      entity.updatedAt = Date()
      entity.category = categoryEntity
      entity.paymentMethod = paymentMethodEntity

      self.generateRecurringData(
        for: transaction,
        to: entity,
        category: categoryEntity,
        paymentMethod: paymentMethodEntity
      )

      try self.context.save()
    }
  }

  func delete(id: UUID) async throws {
    try await context.perform {
      guard let entity = try self.fetchTransactionEntity(by: id) else {
        return
      }

      self.context.delete(entity)
      try self.context.save()
    }
  }

  private func fetchTransactionEntity(by id: UUID) throws -> TransactionEntity? {
    let request = TransactionEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    request.fetchLimit = 1
    return try context.fetch(request).first
  }

  private func fetchCategoryEntity(by id: UUID) throws -> CategoryEntity {
    let request = CategoryEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    request.fetchLimit = 1
    guard let entity = try context.fetch(request).first else {
      throw RepositoryError.relatedEntityNotFound("Category with id \(id) not found.")
    }
    return entity
  }

  private func fetchPaymentMethodEntity(by id: UUID) throws -> PaymentMethodEntity {
    let request = PaymentMethodEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    request.fetchLimit = 1
    guard let entity = try context.fetch(request).first else {
      throw RepositoryError.relatedEntityNotFound("PaymentMethod with id \(id) not found.")
    }
    return entity
  }

  private func generateRecurringData(
    for transaction: Transaction,
    to entity: TransactionEntity,
    category: CategoryEntity,
    paymentMethod: PaymentMethodEntity
  ) {
    if transaction.isInstallment, let months = transaction.installmentMonths, months > 1 {
      let installmentAmount = Int64(Double(transaction.amount) / Double(months))
      for month in 1 ..< months {
        let recurringEntity = RecurringDataEntity(context: context)
        recurringEntity.id = UUID()
        recurringEntity.amount = installmentAmount
        if let futureDate = Calendar.current.date(byAdding: .month, value: month, to: transaction.date) {
          recurringEntity.date = futureDate
        }
        recurringEntity.content = transaction.content
        recurringEntity.type = transaction.transactionType.rawValue
        recurringEntity.createdAt = Date()
        recurringEntity.updatedAt = Date()
        recurringEntity.category = category
        recurringEntity.paymentMethod = paymentMethod
        entity.addToRecurringData(recurringEntity)
      }
    } else if transaction.isRecurring, let rule = transaction.recurringCase {
      guard let oneYearLater = Calendar.current.date(byAdding: .year, value: 1, to: transaction.date) else { return }
      let occurrences = ruleParser.generateOccurrences(
        for: rule,
        startDate: transaction.date,
        endDate: oneYearLater
      )

      for date in occurrences {
        let recurringEntity = RecurringDataEntity(context: context)
        recurringEntity.id = UUID()
        recurringEntity.date = date
        recurringEntity.amount = Int64(transaction.amount)
        recurringEntity.content = transaction.content
        recurringEntity.type = transaction.transactionType.rawValue
        recurringEntity.createdAt = Date()
        recurringEntity.updatedAt = Date()
        recurringEntity.category = category
        recurringEntity.paymentMethod = paymentMethod
        entity.addToRecurringData(recurringEntity)
      }
    }
  }
}
