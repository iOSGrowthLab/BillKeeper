//
//  CategoryRepository.swift
//  BillKeeper
//
//  Created by LCH on 10/25/25.
//

import Foundation

protocol CategoryRepository {
  func fetchAll() async throws -> [Category]
  func fetch(by id: UUID) async throws -> Category?
  func save(_ category: Category) async throws
  func update(_ category: Category) async throws
  func delete(_ id: UUID) async throws
}
