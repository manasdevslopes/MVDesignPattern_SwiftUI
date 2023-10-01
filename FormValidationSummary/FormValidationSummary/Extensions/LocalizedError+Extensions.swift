//
//  LocalizedError+Extensions.swift
//  FormValidationSummary
//
//  Created by MANAS VIJAYWARGIYA on 28/09/23.
//

import Foundation

extension LocalizedError {
  var id: Int {
    localizedDescription.hashValue
  }
}
