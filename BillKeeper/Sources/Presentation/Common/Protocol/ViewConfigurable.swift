//
//  ViewConfigurable.swift
//  BillKeeper
//
//  Created by LCH on 12/6/25.
//

import Foundation

protocol ViewConfigurable {
  func setupView()
  func setupLayout()
}

extension ViewConfigurable {
  func setupUI() {
    setupView()
    setupLayout()
  }
}
