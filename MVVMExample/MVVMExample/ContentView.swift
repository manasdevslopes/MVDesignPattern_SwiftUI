//
//  ContentView.swift
//  MVVMExample
//
//  Created by MANAS VIJAYWARGIYA on 25/09/23.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var vm = ProductListVM(webservice: Webservice())
  
  var body: some View {
    List(vm.products) { product in
      Text(product.title)
    }
    .task {
      await vm.populateProducts()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
