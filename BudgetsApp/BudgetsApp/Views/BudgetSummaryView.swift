//
//  BudgetSummaryView.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 29/10/23.
//

import SwiftUI

struct BudgetSummaryView: View {
  @ObservedObject var budgetCategory: BudgetCategory
  
  var body: some View {
    VStack {
      Text("\(budgetCategory.overSpent ? "Overspent": "Remaining") \(Text(budgetCategory.remainingBudgetTotal.formattedWithAbbreviations()))")
        .frame(maxWidth: .infinity).fontWeight(.bold)
        .foregroundColor(budgetCategory.overSpent ? .red : .green)
    }
  }
}
