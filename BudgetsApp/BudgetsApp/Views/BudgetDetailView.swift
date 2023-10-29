//
//  BudgetDetailView.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 29/10/23.
//

import SwiftUI
import CoreData

struct BudgetDetailView: View {
  @Environment(\.managedObjectContext) private var viewContext
  let budgetCategory: BudgetCategory
  
  @State private var title: String = ""
  @State private var total: String = ""
  
  var isFormValid: Bool {
    guard let totalAsDouble = Double(total) else { return false }
    return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        VStack(alignment: .leading) {
          Text(budgetCategory.title).font(.largeTitle)
          HStack {
            Text("Budget:")
            Text(budgetCategory.total.formattedWithAbbreviations())
          }.fontWeight(.bold)
        }
      }
      
      Form {
        Section {
          TextField("Title", text: $title)
          TextField("Total", text: $total)
        } header: {
          Text("Add Transaction")
        }
        
        Button(action: saveTransaction) {
          Text("Save Transaction")
            .frame(maxWidth: .infinity)
        }.tint(.green).buttonStyle(.bordered).disabled(!isFormValid)
      }.frame(maxHeight: 300).padding([.bottom], 20)
      
      VStack {
        // Display summary of the budget category
        BudgetSummaryView(budgetCategory: budgetCategory)
        
        // Display the transaction
        TransactionListView(request: BudgetCategory.transactionsByCategoryRequest(budgetCategory), onDeleteTransaction: deleteTransaction)
      }
      
      Spacer()
    }.padding()
  }
}

struct BudgetDetailView_Previews: PreviewProvider {
  static var previews: some View {
    BudgetDetailView(budgetCategory: BudgetCategory())
  }
}

extension BudgetDetailView {
  private func saveTransaction() {
    do {
      let transaction = Transaction(context: viewContext)
      transaction.title = title
      transaction.total = Double(total)!
      
      budgetCategory.addToTransactions(transaction)
      try viewContext.save()
      
      self.title = ""
      self.total = ""
    } catch {
      print(error.localizedDescription)
    }
  }
  
  private func deleteTransaction(transaction: Transaction) {
    viewContext.delete(transaction)
    do {
      try viewContext.save()
    } catch {
      print("Unable to Delete Transaction: \(error.localizedDescription)")
    }
  }
}
