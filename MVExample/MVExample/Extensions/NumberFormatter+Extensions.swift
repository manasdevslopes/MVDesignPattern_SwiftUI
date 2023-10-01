//
//  NumberFormatter+Extensions.swift
//  MVExample
//
//  Created by MANAS VIJAYWARGIYA on 26/09/23.
//

import Foundation

extension NumberFormatter {
  static var currency: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
  }
}
