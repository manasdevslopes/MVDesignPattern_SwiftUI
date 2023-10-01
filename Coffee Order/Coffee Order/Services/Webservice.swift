//
//  Webservice.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 30/09/23.
//

import Foundation

enum NetworkError: Error {
  case badRequest
  case decodingError
  case badUrl
}

class Webservice {
  private var baseURL: URL
  init(baseURL: URL) {
    self.baseURL = baseURL
  }
  
  func getOrders() async throws -> [Order] {
    // https://island-bramble.glitch.me/test/orders
    // https://island-bramble.glitch.me/orders
    guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseURL)
    else { throw NetworkError.badUrl }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode>=200 && httpResponse.statusCode < 300
    else { throw NetworkError.badRequest }
    
    guard let orders = try? JSONDecoder().decode([Order].self, from: data)
    else { throw NetworkError.decodingError }
    
    return orders
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








