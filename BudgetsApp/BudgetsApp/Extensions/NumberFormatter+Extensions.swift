//
//  NumberFormatter+Extensions.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 08/10/23.
//

import Foundation

extension NumberFormatter {
  
  static var currency: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
  }
}
