//
//  ContentView.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 08/10/23.
//

import SwiftUI

enum SheetAction: Identifiable {
  case add
  case edit(BudgetCategory)
  
  var id: Int {
    switch self {
      case .add:
        return 1
      case .edit(_):
        return 2
    }
  }
}

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  //  @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
  @FetchRequest(fetchRequest: BudgetCategory.all) var budgetCategoryResults
  @State private var sheetAction: SheetAction?
  
  var body: some View {
    NavigationStack {
      VStack {
        HStack {
          Text("Total Budget -")
          Text(total.formattedWithAbbreviations()).fontWeight(.bold)
        }
        BudgetListView(budgetCategoryResults: budgetCategoryResults, onDeleteBudgetCategory: deleteBudgetCategory, onEditBudgetCategory: editBudgetCategory)
      }
      .padding()
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Add Category") {
            sheetAction = .add
          }
        }
      }
      .sheet(item: $sheetAction) { sheetAction in
        switch sheetAction {
          case .add:
            AddBudgetCategoryView()
          case .edit(let budgetCategory):
            AddBudgetCategoryView(budgetCategory: budgetCategory)
        }
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
  
  private func editBudgetCategory(budgetCategory: BudgetCategory) {
    sheetAction = .edit(budgetCategory)
  }
}
