//
//  StoreModel.swift
//  MVExample
//
//  Created by MANAS VIJAYWARGIYA on 26/09/23.
//

import Foundation

@MainActor
class StoreModel: ObservableObject {
  @Published var products: [Product] = []
  
  let webservice: Webservice
  
  init(webservice: Webservice) {
    self.webservice = webservice
  }
  
  func populateProducts() async {
    do {
      self.products = try await webservice.getProducts()
    } catch {
      print(error)
    }
  }
}
