//
//  ValidationSummaryView.swift
//  FormValidationSummary
//
//  Created by MANAS VIJAYWARGIYA on 28/09/23.
//

import SwiftUI

struct ValidationSummaryView: View {
  let errors: [LocalizedError]
  
    var body: some View {
      ForEach(errors, id: \.id) { error in
        Text(error.localizedDescription)
      }
    }
}

struct ValidationSummaryView_Previews: PreviewProvider {
    static var previews: some View {
      ValidationSummaryView(errors: [])
    }
}
