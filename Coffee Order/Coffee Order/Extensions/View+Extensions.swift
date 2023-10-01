//
//  View+Extensions.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 01/10/23.
//

import Foundation
import SwiftUI

extension View {
  func centerHorizontally() -> some View {
    HStack {
      Spacer()
      self
      Spacer()
    }
  }
  
  @ViewBuilder
  func visible(_ value: Bool) -> some View {
    switch value {
      case true:
        self
      case false:
        EmptyView()
    }
  }
}
