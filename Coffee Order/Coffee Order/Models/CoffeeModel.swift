//
//  CoffeeModel.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 30/09/23.
//

import Foundation

@MainActor
class CoffeeModel: ObservableObject {
  let webservice: Webservice
  init(webservice: Webservice) {
    self.webservice = webservice
  }
  
  @Published private(set) var orders: [Order] = []
  
  func populateOrders() async throws {
    self.orders = try await webservice.getOrders()
  }
}
