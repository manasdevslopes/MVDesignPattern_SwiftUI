//
//  AddBudgetCategoryView.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 08/10/23.
//

import SwiftUI

struct AddBudgetCategoryView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.dismiss) private var dismiss
  @State private var title: String = ""
  @State private var total: Double = 1000
  @State private var messages: [String] = []
  
  private var budgetCategory: BudgetCategory?
  init(budgetCategory: BudgetCategory? = nil) {
    self.budgetCategory = budgetCategory
  }
  
  var isFormValid: Bool {
    messages.removeAll()
    if title.isEmpty {
      messages.append("Title is required")
    }
    if total <= 0 {
      messages.append("Total should be greater than 1")
    }
    return messages.count == 0
  }
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Title", text: $title)
        Slider(value: $total, in: 0...25000, step: 500) {
          Text("Total")
        } minimumValueLabel: {
          Text("\u{20B9}0")
        } maximumValueLabel: {
          Text("\u{20B9}25000")
        }
//        Text(total as NSNumber, formatter: NumberFormatter.currency)
//          .frame(maxWidth: .infinity, alignment: .center)
        Text(total.formattedWithAbbreviations()).frame(maxWidth: .infinity, alignment: .center)
        
        ForEach(messages, id: \.self) { message in
          Text(message)
        }
      }
      .onAppear {
        if let budgetCategory {
          title = budgetCategory.title
          total = budgetCategory.total
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Cancel") { dismiss() }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Save") {
            if isFormValid {
              saveOrUpdate()
            }
          }
        }
      }
    }
  }
}

struct AddBudgetCategoryView_Previews: PreviewProvider {
  static var previews: some View {
    AddBudgetCategoryView()
  }
}

extension AddBudgetCategoryView {
  private func saveOrUpdate() {
    if let budgetCategory {
      // update the existing budget category
      let budget = BudgetCategory.byId(budgetCategory.objectID)
      budget.title = title
      budget.total = total
    } else {
      let budgetCategory = BudgetCategory(context: viewContext)
      budgetCategory.title = title
      budgetCategory.total = total
    }
    do {
      try viewContext.save()
      dismiss()
    } catch {
      print(error.localizedDescription)
    }
  }
}
