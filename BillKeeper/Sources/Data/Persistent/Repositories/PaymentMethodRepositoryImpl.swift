//
//  PaymentMethodRepositoryImpl.swift
//  BillKeeper
//
//  Created by LCH on 10/28/25.
//

import CoreData

final class PaymentMethodRepositoryImpl: PaymentMethodRepository {
  private let context: NSManagedObjectContext
  
  init(context: NSManagedObjectContext) {
    self.context = context
  }
  
  func fetchAll() async throws -> [PaymentMethod] {
    try await context.perform {
      let request = PaymentMethodEntity.fetchRequest()
      let entities = try self.context.fetch(request)
      return entities.map { $0.toDomain() }
    }
  }
  
  func fetch(by id: UUID) async throws -> PaymentMethod? {
    try await context.perform {
      let request = PaymentMethodEntity.fetchRequest()
      request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
      request.fetchLimit = 1
      let entity = try self.context.fetch(request).first
      return entity?.toDomain()
    }
  }
  
  func save(_ paymentMethod: PaymentMethod) async throws {
    try await context.perform {
      let entity = PaymentMethodEntity(context: self.context)
      entity.id = paymentMethod.id
      entity.name = paymentMethod.name
      entity.isDefault = paymentMethod.isDefault
      try self.context.save()
    }
  }
  
  func update(_ paymentMethod: PaymentMethod) async throws {
    try await context.perform {
      let request = PaymentMethodEntity.fetchRequest()
      request.predicate = NSPredicate(format: "id == %@", paymentMethod.id as CVarArg)
      request.fetchLimit = 1
      
      guard let entity = try self.context.fetch(request).first else {
        throw RepositoryError.notFound
      }
      
      entity.name = paymentMethod.name
      entity.isDefault = paymentMethod.isDefault
      try self.context.save()
    }
  }
  
  func delete(_ id: UUID) async throws {
    try await context.perform {
      let request = PaymentMethodEntity.fetchRequest()
      request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
      request.fetchLimit = 1
      
      guard let entity = try self.context.fetch(request).first else {
        return
      }
      
      self.context.delete(entity)
      try self.context.save()
    }
  }
}
