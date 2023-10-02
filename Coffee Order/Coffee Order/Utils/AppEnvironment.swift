//
//  AppEnvironment.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 30/09/23.
//

import Foundation

enum Endpoints {
  case allOrders
  case placeOrders
  case deleteOrder(Int)
  case updateOrder(Int)
  
  var path: String {
    switch self {
      case .allOrders:
        return "/test/orders" // /orders // /test/orders
      case .placeOrders:
        return "/test/new-order" // /newOrder, // /test/orders
      case .deleteOrder(let orderId):
        return "/test/orders/\(orderId)" // /orders/:id, // /test/orders/:id
      case .updateOrder(let orderId):
        return "/test/orders/\(orderId)" // /orders/:id, // /test/orders/:id
    }
  }
}

struct Configuration {
  lazy var environment: AppEnvironment = {
    // read value from environment variable
    guard let env = ProcessInfo.processInfo.environment["ENV"] else { return AppEnvironment.dev }
    
    if env == "TEST" {
      return AppEnvironment.test
    } else if env == "PROD" {
      return AppEnvironment.prod
    }
    return AppEnvironment.dev
  }()
}

enum AppEnvironment: String {
  case dev
  case test
  case prod
  
  var baseURL: URL {
    switch self {
      case .dev:
        return URL(string: "https://island-bramble.glitch.me")!
      case .test:
        return URL(string: "https://island-bramble.glitch.me")!
      case .prod:
        return URL(string: "https://island-bramble.glitch.me")!
    }
  }
}


//Resource: TEST Server Endpoints
//Endpoints
//
//Get all orders:
//
//method: GET
//
//https://island-bramble.glitch.me/test/orders
//
//Create a new order:
//
//method: POST
//
//https://island-bramble.glitch.me/test/orders
//
//Body:
//
//{
//  "name": "John Doe",
//  "coffeeName": "Hot Coffee",
//  "total": 4.50,
//  "size": "Medium"
//}
//Delete an order:
//
//method: DELETE
//
//https://island-bramble.glitch.me/test/orders/:id
//
//Update an order:
//
//method: PUT
//
//https://island-bramble.glitch.me/test/orders/:id
//
//Body:
//
//{
//  "name": "John Doe Edit",
//  "coffeeName": "Hot Coffee Edit",
//  "total": 2.50,
//  "size": "Small"
//}


//Resource: PROD Server Endpoints
//Endpoints
//Get all orders:
//
//method: GET
//
//https://island-bramble.glitch.me/orders
//
//Create a new order:
//
//method: POST
//
//https://island-bramble.glitch.me/newOrder
//
//Body:
//
//{
//  "name": "John Doe",
//  "coffeeName": "Hot Coffee",
//  "total": 4.50,
//  "size": "Medium"
//}
//Delete an order:
//
//method: DELETE
//
//https://island-bramble.glitch.me/orders/:id
//
//
//
//Update an order:
//
//method: PUT
//
//https://island-bramble.glitch.me/orders/:id
//
//Body:
//
//{
//  "name": "John Doe Edit",
//  "coffeeName": "Hot Coffee Edit",
//  "total": 2.50,
//  "size": "Small"
//}








