//
//  HomeView.swift
//  BillKeeper
//
//  Created by LCH on 11/17/25.
//

import UIKit

class HomeView: UIViewController, ViewConfigurable {
  private enum Section: Int, CaseIterable, Hashable {
    case main
  }

  // TODO: Reactor Binding시 isOpened 삭제
  private var isOpened = false
  private var calendarHeightConstraint: NSLayoutConstraint!
  private var dataSource: UICollectionViewDiffableDataSource<Section, TransactionDummy>!

  private let calendarButton: UIButton = {
    let button = UIButton()
    button.titleLabel?.font = .Pretendard.subtitleL
    button.setTitleColor(.Neutral.black, for: .normal)
    button.setImage(UIImage(named: "plus"), for: .normal)

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 MM월 dd일"
    button.setTitle(formatter.string(from: Date.now), for: .normal)

    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private let calendarView: UICalendarView = {
    let calendar = UICalendarView()
    calendar.translatesAutoresizingMaskIntoConstraints = false
    return calendar
  }()

  private var collectionView: UICollectionView!

  private let addButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.backgroundColor = .Status.interactive
    button.tintColor = .white
    button.layer.cornerRadius = 22
    button.clipsToBounds = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    configureDataSource()
    applySnapshot(accounts: dummyTransactionData)

    // TODO: Reactor Binding시 addTarget 삭제
    calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
  }

  func setupView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout.homeList)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .clear
    collectionView.register(TransactionCell.self, forCellWithReuseIdentifier: String(describing: TransactionCell.self))

    view.backgroundColor = .Surface.primary
    view.addSubview(calendarButton)
    view.addSubview(calendarView)
    view.addSubview(collectionView)
    view.addSubview(addButton)

    let calendarselction = UICalendarSelectionSingleDate(delegate: self)
    calendarView.selectionBehavior = calendarselction

    collectionView.register(TransactionCell.self, forCellWithReuseIdentifier: String(describing: TransactionCell.self))
  }

  func setupLayout() {
    calendarHeightConstraint = calendarView.heightAnchor.constraint(equalToConstant: 0)

    NSLayoutConstraint.activate([
      calendarButton.heightAnchor.constraint(equalToConstant: 54),
      calendarButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      calendarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      calendarView.topAnchor.constraint(equalTo: calendarButton.bottomAnchor, constant: 4),
      calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      calendarHeightConstraint,

      collectionView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 8),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

      addButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 44),
      addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor),
      addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    ])
  }

  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, TransactionDummy>(collectionView: collectionView) { collectionView, indexPath, list in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TransactionCell.self), for: indexPath) as? TransactionCell else {
        return UICollectionViewCell()
      }

      cell.setData(data: list)
      return cell
    }
  }

  private func applySnapshot(accounts: [TransactionDummy]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, TransactionDummy>()
    snapshot.appendSections([.main])
    snapshot.appendItems(accounts, toSection: .main)

    dataSource.apply(snapshot, animatingDifferences: true)
  }

  private func expendCalendar(_ isOpened: Bool) {
    let height = isOpened ? calendarView.intrinsicContentSize.height : 0
    calendarHeightConstraint.constant = height

    UIView.animate(withDuration: 0.25) {
      self.view.layoutIfNeeded()
    }
  }

  // TODO: Reactor Binding시 objc func 삭제
  @objc private func calendarButtonTapped() {
    isOpened.toggle()
    expendCalendar(isOpened)
  }
}

extension HomeView: UICalendarSelectionSingleDateDelegate {
  func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
    selection.setSelected(dateComponents, animated: true)
    selection.selectedDate = dateComponents
  }
}

private extension UICollectionViewCompositionalLayout {
  static var homeList: UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 8

    return UICollectionViewCompositionalLayout(section: section)
  }
}
