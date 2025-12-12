//
//  SplashView.swift
//  BillKeeper
//
//  Created by LCH on 11/17/25.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

final class SplashView: UIViewController, ViewConfigurable {
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(resource: .logo)
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  func setupView() {
    view.addSubview(imageView)
    view.backgroundColor = .Brand.primary
  }

  func setupLayout() {
    NSLayoutConstraint.activate([
      imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
      imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
      imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24)
    ])
  }
}
