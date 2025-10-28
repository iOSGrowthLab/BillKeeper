//
//  Transaction.swift
//  BillKeeper
//
//  Created by LCH on 10/25/25.
//

import Foundation

struct Transaction {
  let id: UUID
  let categoryId: UUID
  let paymentMethodId: UUID
  let recurringIds: [UUID]
  let updatedAt: Date
  let date: Date
  let amount: Int
  let content: String
  let transactionType: TransactionType
  let isRecurring: Bool
  let recurringCase: RecurringCase?
  let expiredAt: Date?
  let isInstallment: Bool
  let installmentMonths: Int?
}
