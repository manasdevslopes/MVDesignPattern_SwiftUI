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
    print("try await webservice.getOrders()", try await webservice.getOrders())
    self.orders = try await webservice.getOrders()
  }
  
  func placeOrder(_ order: Order) async throws {
    let newOrder = try await webservice.placeOrder(order: order)
    orders.append(newOrder)
  }
  
  func deleteOrder(_ orderId: Int) async throws {
    let deletedOrder = try await webservice.deleteOrder(orderId: orderId)
    print("deletedOrder------->", deletedOrder)
    orders = orders.filter { $0.id != deletedOrder.id }
  }
  
  func updateOrder(_ order: Order) async throws {
    let updatedOrder = try await webservice.updateOrder(order)
    guard let index = orders.firstIndex(where: { $0.id == updatedOrder.id })
    else { throw CoffeeOrderError.inValidOrderId }
    orders[index] = updatedOrder
  }
}
