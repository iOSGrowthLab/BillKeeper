//
//  TransactionCell.swift
//  BillKeeper
//
//  Created by LCH on 12/5/25.
//

import UIKit

final class TransactionCell: UICollectionViewCell, ViewConfigurable {
  private let categoryImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .black
    imageView.layer.cornerRadius = 20
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let dateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: .Pretendard.bodyM)
    label.textColor = .Neutral.level600
    label.adjustsFontForContentSizeCategory = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let categoryLabel: UILabel = {
    let label = UILabel()
    label.font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: .Pretendard.subtitleS)
    label.textColor = .Neutral.level800
    label.adjustsFontForContentSizeCategory = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let memoLabel: UILabel = {
    let label = UILabel()
    label.font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: .Pretendard.bodyL)
    label.textColor = .Neutral.black
    label.adjustsFontForContentSizeCategory = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let valueLabel: UILabel = {
    let label = UILabel()
    label.font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: .Pretendard.headingS)
    label.textColor = .Status.expense
    label.adjustsFontForContentSizeCategory = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupView() {
    backgroundColor = .Neutral.white
    layer.cornerRadius = 14
    layer.masksToBounds = true
    layer.borderColor = UIColor.Neutral.level200?.cgColor
    layer.borderWidth = CGFloat(0.8)

    contentView.addSubview(categoryImage)
    contentView.addSubview(dateLabel)
    contentView.addSubview(categoryLabel)
    contentView.addSubview(memoLabel)
    contentView.addSubview(valueLabel)
  }

  func setupLayout() {
    NSLayoutConstraint.activate([
      categoryImage.widthAnchor.constraint(equalToConstant: 40),
      categoryImage.heightAnchor.constraint(equalToConstant: 40),
      categoryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
      categoryImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      dateLabel.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: 12),
      dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

      categoryLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 8),
      categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

      memoLabel.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: 12),
      memoLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6),
      memoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

      valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
      valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

  // TODO: Reactor binding시 로직 작성 필요
  func setData(data: TransactionDummy) {
    categoryImage.image = UIImage(named: data.category.rawValue)
    categoryImage.backgroundColor = data.category.color
    categoryLabel.text = data.category.name
    dateLabel.text = data.date
    memoLabel.text = data.memo
    valueLabel.text = data.price

    switch data.type {
      case .income:
        valueLabel.textColor = .Status.income
        valueLabel.text = data.price
      case .expense:
        valueLabel.textColor = .Status.expense
        valueLabel.text = "-\(data.price)"
    }
  }
}
