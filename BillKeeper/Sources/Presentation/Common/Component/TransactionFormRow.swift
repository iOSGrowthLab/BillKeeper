//
//  TransactionFormRow.swift
//  BillKeeper
//
//  Created by LCH on 12/12/25.
//

import UIKit

final class TransactionFormRow: UIStackView {
  private var textLabel: TransactionLabel!
  private var textField: TransactionField!

  init(label: String, placeholderText: String) {
    super.init(frame: .zero)
    textLabel = TransactionLabel(text: label)
    textField = TransactionField(placeholderText: placeholderText)
    setup()
  }

  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    addArrangedSubview(textLabel)
    addArrangedSubview(textField)

    axis = .horizontal
    spacing = 32
    distribution = .fill
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: 44).isActive = true

    textLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    textLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

    textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
    textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
  }

  func setKeyboardType(_ type: UIKeyboardType) {
    textField.keyboardType = type
  }

  func setUserInteraction(_ isEnabled: Bool) {
    textField.isUserInteractionEnabled = isEnabled
  }

  var labelWidthAnchor: NSLayoutDimension {
    return textLabel.widthAnchor
  }
}
