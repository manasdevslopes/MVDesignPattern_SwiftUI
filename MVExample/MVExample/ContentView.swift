//
//  ContentView.swift
//  MVExample
//
//  Created by MANAS VIJAYWARGIYA on 26/09/23.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var storeModel: StoreModel
  
  var body: some View {
    VStack {
      List(storeModel.products) { product in
        HStack(alignment: .top) {
          Text(product.title)
          Spacer()
          Text(product.price as NSNumber, formatter: NumberFormatter.currency)
        }
      }
    }
    .task {
      await storeModel.populateProducts()
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(StoreModel(webservice: Webservice()))
  }
}
