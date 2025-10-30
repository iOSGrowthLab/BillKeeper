//
//  CategoryRepositoryImpl.swift
//  BillKeeper
//
//  Created by LCH on 10/27/25.
//

import CoreData

final class CategoryRepositoryImpl: CategoryRepository {
  private let context: NSManagedObjectContext
  
  init(context: NSManagedObjectContext) {
    self.context = context
  }
  
  func fetchAll() async throws -> [Category] {
    try await context.perform {
      let request = CategoryEntity.fetchRequest()
      let entities = try self.context.fetch(request)
      return entities.map { $0.toDomain() }
    }
  }
  
  func fetch(by id: UUID) async throws -> Category? {
    try await context.perform {
      let request = CategoryEntity.fetchRequest()
      request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
      request.fetchLimit = 1
      let entity = try self.context.fetch(request).first
      return entity?.toDomain()
    }
  }
  
  func save(_ category: Category) async throws {
    try await context.perform {
      let entity = CategoryEntity(context: self.context)
      entity.id = category.id
      entity.name = category.name
      entity.isDefault = category.isDefault
      try self.context.save()
    }
  }
  
  func update(_ category: Category) async throws {
    try await context.perform {
      let request = CategoryEntity.fetchRequest()
      request.predicate = NSPredicate(format: "id == %@", category.id as CVarArg)
      request.fetchLimit = 1
      
      guard let entity = try self.context.fetch(request).first else {
        throw RepositoryError.notFound
      }
      
      entity.name = category.name
      entity.isDefault = category.isDefault
      try self.context.save()
    }
  }
  
  func delete(_ id: UUID) async throws {
    try await context.perform {
      let request = CategoryEntity.fetchRequest()
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
