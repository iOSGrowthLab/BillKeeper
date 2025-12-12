//
//  TransactionField.swift
//  BillKeeper
//
//  Created by LCH on 12/12/25.
//

import UIKit

final class TransactionField: UITextField {
  init(placeholderText: String) {
    super.init(frame: .zero)
    placeholder = placeholderText
    setup()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    font = .Pretendard.bodyL
    textColor = .Neutral.black
    translatesAutoresizingMaskIntoConstraints = false
  }
}
