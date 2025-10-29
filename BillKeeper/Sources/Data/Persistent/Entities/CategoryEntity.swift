//
//  CategoryEntity.swift
//  BillKeeper
//
//  Created by LCH on 10/27/25.
//
//

import CoreData

@objc(Category)
final class CategoryEntity: NSManagedObject {
  @NSManaged var id: UUID
  @NSManaged var isDefault: Bool
  @NSManaged var name: String
  @NSManaged var recurringData: NSSet?
  @NSManaged var transactions: NSSet?
}
