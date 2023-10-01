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
  
  func placeOrder(order: Order) async throws -> Order {
    guard let url = URL(string: Endpoints.placeOrders.path, relativeTo: baseURL)
    else { throw NetworkError.badUrl }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(order)
    
    let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
    else { throw NetworkError.badRequest }
    
    guard let newOrder = try? JSONDecoder().decode(Order.self, from: data)
    else { throw NetworkError.decodingError }
    
    return newOrder
  }
  
  func deleteOrder(orderId: Int) async throws -> Order {
    guard let url = URL(string: Endpoints.deleteOrder(orderId).path, relativeTo: baseURL)
    else { throw NetworkError.badUrl }
    
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    
    let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
    else { throw NetworkError.badRequest }
    print("DATA------>", data)
    guard let deletedOrder = try? JSONDecoder().decode(Order.self, from: data)
    else { throw NetworkError.decodingError }
    
    return deletedOrder
  }
  
  func updateOrder(_ order: Order) async throws -> Order {
    guard let orderId = order.id else { throw NetworkError.badUrl }
    guard let url = URL(string: Endpoints.updateOrder(orderId).path, relativeTo: baseURL)
    else { throw NetworkError.badUrl }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
    else { throw NetworkError.badRequest }
    
    guard let updatedOrder = try? JSONDecoder().decode(Order.self, from: data)
    else { throw NetworkError.decodingError }
    
    return updatedOrder
  }
}
