//
//  PaymentMethodEntity.swift
//  BillKeeper
//
//  Created by LCH on 10/27/25.
//
//

import CoreData

@objc(PaymentMethod)
final class PaymentMethodEntity: NSManagedObject {
  @NSManaged var id: UUID
  @NSManaged var isDefault: Bool
  @NSManaged var name: String
  @NSManaged var recurringData: NSSet?
  @NSManaged var transactions: NSSet?
}
