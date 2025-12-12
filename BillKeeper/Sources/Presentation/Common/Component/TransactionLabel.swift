//
//  TransactionLabel.swift
//  BillKeeper
//
//  Created by LCH on 12/12/25.
//

import UIKit

final class TransactionLabel: UILabel {
  init(text: String) {
    super.init(frame: .zero)
    self.text = text
    setup()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: .Pretendard.subtitleL)
    textColor = .Neutral.black
    translatesAutoresizingMaskIntoConstraints = false
  }
}
