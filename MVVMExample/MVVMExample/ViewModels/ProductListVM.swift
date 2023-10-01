//
//  ProductListVM.swift
//  MVVMExample
//
//  Created by MANAS VIJAYWARGIYA on 25/09/23.
//

import Foundation

@MainActor
class ProductListVM: ObservableObject {
  @Published var products: [ProductViewModel] = []
  
  let webservice: Webservice
  
  init(webservice: Webservice) {
    self.webservice = webservice
  }
  
  func populateProducts() async {
    do {
      let products = try await webservice.getProducts()
      print("products---------->", products)
      self.products = products.map(ProductViewModel.init)
    } catch {
      print(error)
    }
  }
}

struct ProductViewModel: Identifiable {
  private var product: Product
  
  init(product: Product) {
    self.product = product
  }
  
  var id: Int {
    product.id
  }
  
  var title: String {
    product.title
  }
  
  var price: Double {
    product.price
  }
}
