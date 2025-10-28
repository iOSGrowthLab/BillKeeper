//
//  TransactionRepository.swift
//  BillKeeper
//
//  Created by LCH on 10/25/25.
//

import Foundation

protocol TransactionRepository {
  func fetchAll() async throws -> [Transaction]
  func fetch(by id: UUID) async throws -> Transaction?
  func fetchByDateRange(from startDate: Date, to endDate: Date) async throws -> [Transaction]
  func save(_ transaction: Transaction) async throws
  func update(_ transaction: Transaction) async throws
  func delete(id: UUID) async throws
}
