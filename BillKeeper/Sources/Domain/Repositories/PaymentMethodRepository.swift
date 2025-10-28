//
//  PaymentMethodRepository.swift
//  BillKeeper
//
//  Created by LCH on 10/25/25.
//

import Foundation

protocol PaymentMethodRepository {
  func fetchAll() async throws -> [PaymentMethod]
  func fetch(by id: UUID) async throws -> PaymentMethod?
  func save(_ paymentMethod: PaymentMethod) async throws
  func update(_ paymentMethod: PaymentMethod) async throws
  func delete(_ id: UUID) async throws
}
