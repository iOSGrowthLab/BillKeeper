//
//  RepositoryError.swift
//  BillKeeper
//
//  Created by LCH on 10/28/25.
//

import Foundation

enum RepositoryError: Error, Equatable {
  case notFound
  case relatedEntityNotFound(String)
  case mappingFailed(String)
  case storageError(String)
}
