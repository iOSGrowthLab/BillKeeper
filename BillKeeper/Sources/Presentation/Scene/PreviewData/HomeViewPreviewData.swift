//
//  HomeViewPreviewData.swift
//  BillKeeper
//
//  Created by LCH on 12/12/25.
//

import UIKit

// MARK: UILayout용 Dummy

/// UILayout용 Dummy 구조체
struct TransactionDummy: Hashable {
  let date: String
  let category: CategoryDummyImage
  let type: DummyType
  let memo: String
  let price: String
}

/// UILayout용 DummyType 열거형
enum DummyType {
  case income
  case expense
}

/// UILayout용 dummyTransactionData 열거형
var dummyTransactionData = [
  TransactionDummy(date: "10/06", category: .cafe, type: .expense, memo: "스타벅스", price: "6500원"),
  TransactionDummy(date: "10/06", category: .play, type: .income, memo: "스피또", price: "5000원"),
  TransactionDummy(date: "10/06", category: .traffic, type: .expense, memo: "지하철", price: "1500원"),
  TransactionDummy(date: "10/06", category: .food, type: .expense, memo: "GS25", price: "6800원"),
  TransactionDummy(date: "10/06", category: .play, type: .expense, memo: "로또 6/45", price: "5000원"),
  TransactionDummy(date: "10/06", category: .health, type: .expense, memo: "이비인후과", price: "5300원")
]

/// UILayout용 CategoryDummyImage 열거형
enum CategoryDummyImage: String {
  case cafe
  case food
  case gas
  case health
  case income
  case play
  case shopping
  case traffic

  var name: String {
    switch self {
      case .cafe:
        return "카페"
      case .food:
        return "식비"
      case .gas:
        return "주유"
      case .health:
        return "건강"
      case .income:
        return "수입"
      case .play:
        return "오락"
      case .shopping:
        return "쇼핑"
      case .traffic:
        return "교통"
    }
  }

  var color: UIColor? {
    switch self {
      case .cafe:
        return .Category.vividAmber
      case .food:
        return .Category.vividOrange
      case .gas:
        return .Category.charcoalGray
      case .health:
        return .Category.brightRed
      case .income:
        return .Category.deepBlue
      case .play:
        return .Category.pinkMagenta
      case .shopping:
        return .Category.vividViolet
      case .traffic:
        return .Category.brightGreen
    }
  }
}
