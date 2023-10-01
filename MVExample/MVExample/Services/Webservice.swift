//
//  Webservice.swift
//  MVExample
//
//  Created by MANAS VIJAYWARGIYA on 26/09/23.
//

import Foundation

enum NetworkError: Error {
  case badUrl
  case badRequest
  case decodingError
}

class Webservice {
  func getProducts() async throws -> [Product] {
    guard let url = URL(string: "https://fakestoreapi.com/products") else { throw NetworkError.badUrl }

    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { throw NetworkError.badRequest }
    
    guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
      throw NetworkError.decodingError
    }
    
    return products
  }
}
