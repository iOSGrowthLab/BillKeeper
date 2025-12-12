//
//  TransactionAddView.swift
//  BillKeeper
//
//  Created by LCH on 11/17/25.
//

import UIKit

final class TransactionAddView: UIViewController, ViewConfigurable {
  private let segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: ["지출", "수입"])
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.setTitleTextAttributes([.font: UIFont.Pretendard.subtitleS], for: .normal)
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return segmentedControl
  }()

  private let dateForm = TransactionFormRow(label: "날짜", placeholderText: "날짜를 선택해 주세요")
  private let amountForm = TransactionFormRow(label: "금액", placeholderText: "금액을 입력해 주세요")
  private let categoryForm = TransactionFormRow(label: "분류", placeholderText: "분류를 선택해 주세요")
  private let paymentForm = TransactionFormRow(label: "자산", placeholderText: "자산을 선택해 주세요")
  private let memoForm = TransactionFormRow(label: "내용", placeholderText: "내용을 입력해 주세요")
  private let recurringForm = TransactionFormRow(label: "반복/할부", placeholderText: "없음")

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      dateForm,
      amountForm,
      categoryForm,
      paymentForm,
      memoForm,
      recurringForm
    ])
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.spacing = 0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let saveButton: UIButton = {
    let button = UIButton()
    button.setTitle("저장", for: .normal)
    button.titleLabel?.font = .Pretendard.subtitleM
    button.setTitleColor(.Neutral.white, for: .normal)
    button.backgroundColor = .Brand.primary
    button.layer.cornerRadius = 10
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private let cancelButton: UIButton = {
    let button = UIButton()
    button.setTitle("계속 추가", for: .normal)
    button.titleLabel?.font = .Pretendard.subtitleM
    button.setTitleColor(.Neutral.white, for: .normal)
    button.backgroundColor = .Brand.secondary
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 10
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  func setupView() {
    view.backgroundColor = .Surface.primary

    view.addSubview(segmentedControl)
    view.addSubview(stackView)
    view.addSubview(saveButton)
    view.addSubview(cancelButton)
  }

  func setupLayout() {
    NSLayoutConstraint.activate([
      segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
      segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
      segmentedControl.heightAnchor.constraint(equalToConstant: 36),
      segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

      stackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
      stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -28),

      dateForm.labelWidthAnchor.constraint(greaterThanOrEqualTo: recurringForm.labelWidthAnchor),
      amountForm.labelWidthAnchor.constraint(greaterThanOrEqualTo: recurringForm.labelWidthAnchor),
      categoryForm.labelWidthAnchor.constraint(greaterThanOrEqualTo: recurringForm.labelWidthAnchor),
      paymentForm.labelWidthAnchor.constraint(greaterThanOrEqualTo: recurringForm.labelWidthAnchor),
      memoForm.labelWidthAnchor.constraint(greaterThanOrEqualTo: recurringForm.labelWidthAnchor),

      saveButton.widthAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 3),
      saveButton.heightAnchor.constraint(equalToConstant: 80),
      saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
      saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),

      cancelButton.heightAnchor.constraint(equalToConstant: 80),
      cancelButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 16),
      cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
      cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
    ])
  }
}
