//
//  BudgetListView.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 08/10/23.
//

import SwiftUI

struct BudgetListView: View {
  let budgetCategoryResults: FetchedResults<BudgetCategory>
  let onDeleteBudgetCategory: (BudgetCategory) -> ()
  
    var body: some View {
      List {
        if !budgetCategoryResults.isEmpty {
          ForEach(budgetCategoryResults) { budgetCategory in
            HStack {
              Text(budgetCategory.title)
              Spacer()
              VStack {
                Text(budgetCategory.total.formattedWithAbbreviations())
              }
            }
          }
          .onDelete(perform: delete)
        } else {
          Text("No Budget categories exists.")
        }
      }
    }
}

extension BudgetListView {
  private func delete(indexSet: IndexSet) {
    indexSet.map { budgetCategoryResults[$0] }.forEach(onDeleteBudgetCategory)
  }
}
