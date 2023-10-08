//
//  ContentView.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 08/10/23.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
  
  @State private var isPresented: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        Text(total.formattedWithAbbreviations()).fontWeight(.bold)
        BudgetListView(budgetCategoryResults: budgetCategoryResults, onDeleteBudgetCategory: deleteBudgetCategory)
      }
      .padding()
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Add Category") {
            isPresented.toggle()
          }
        }
      }
      .sheet(isPresented: $isPresented) {
        AddBudgetCategoryView()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
  }
}

extension ContentView {
  var total: Double {
    budgetCategoryResults.reduce(0, { $0 + $1.total })
  }
  
  private func deleteBudgetCategory(budgetCategory: BudgetCategory) {
    viewContext.delete(budgetCategory)
    do {
      try viewContext.save()
    } catch {
      print("Unable to Delete : \(error.localizedDescription)")
    }
  }
}
