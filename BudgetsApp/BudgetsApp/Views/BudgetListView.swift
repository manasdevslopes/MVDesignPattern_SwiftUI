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
  let onEditBudgetCategory: (BudgetCategory) -> ()
  
    var body: some View {
      List {
        if !budgetCategoryResults.isEmpty {
          ForEach(budgetCategoryResults) { budgetCategory in
            NavigationLink(value: budgetCategory) {
              HStack {
                Text(budgetCategory.title)
                Spacer()
                VStack(alignment: .trailing, spacing: 10) {
                  Text(budgetCategory.total.formattedWithAbbreviations())
                  Text("\(budgetCategory.overSpent ? "Overspent": "Remaining") \(Text(budgetCategory.remainingBudgetTotal.formattedWithAbbreviations()))")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .fontWeight(.bold)
                    .foregroundColor(budgetCategory.overSpent ? .red: .green)
                }
              }
              .contentShape(Rectangle())
              .onLongPressGesture {
                onEditBudgetCategory(budgetCategory)
              }
            }
          }
          .onDelete(perform: delete)
        } else {
          Text("No Budget categories exists.")
        }
      }
      .listStyle(.plain)
      .navigationDestination(for: BudgetCategory.self) { budgetCategory in
        BudgetDetailView(budgetCategory: budgetCategory)
      }
    }
}

extension BudgetListView {
  private func delete(indexSet: IndexSet) {
    indexSet.map { budgetCategoryResults[$0] }.forEach(onDeleteBudgetCategory)
  }
}
