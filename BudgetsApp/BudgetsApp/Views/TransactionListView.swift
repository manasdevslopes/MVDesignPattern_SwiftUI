//
//  TransactionListView.swift
//  BudgetsApp
//
//  Created by MANAS VIJAYWARGIYA on 29/10/23.
//

import SwiftUI
import CoreData

struct TransactionListView: View {
  @FetchRequest var transactions: FetchedResults<Transaction>
  let onDeleteTransaction: (Transaction) -> ()

  init(request: NSFetchRequest<Transaction>, onDeleteTransaction: @escaping (Transaction) -> ()) {
    _transactions = FetchRequest(fetchRequest: request)
    self.onDeleteTransaction = onDeleteTransaction
  }
  
    var body: some View {
      if transactions.isEmpty {
        Text("No transactions.")
      } else {
        List {
          ForEach(transactions) { transaction in
            HStack {
              Text(transaction.title)
              Spacer()
              Text(transaction.total.formattedWithAbbreviations())
            }
          }
          .onDelete(perform: delete)
        }
      }
    }
}

extension TransactionListView {
  private func delete(indexSet: IndexSet) {
    indexSet.map { transactions[$0] }.forEach(onDeleteTransaction)
  }
}
