//
//  AddOperationView.swift
//  Budget
//
//  Created by Anna Kochanova on 26.02.2026.
//

import SwiftUI

struct OperationFormView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var formViewModel: FormViewModel
    
    init(listViewModel: ListViewModel, operation: Operation? = nil) {
        _formViewModel = StateObject(
            wrappedValue: FormViewModel(
                listViewModel: listViewModel,
                operation: operation
            )
        )
    }
    
    var body: some View {
        VStack {
            
            TextField("Title",
                      text: $formViewModel.newOperationTitle)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            TextField("Amount",
                      text: $formViewModel.newOperationAmount)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            DatePicker("Date",
                selection: $formViewModel.newOperationDate,
                displayedComponents: .date
            )
            .padding()
            
            Button(isEditing ? "Update" : "Add") {
                if formViewModel.save(){
                    dismiss()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .padding()
    }
    
    private var isEditing: Bool {
            formViewModel.originalOperation != nil
        }
}

#Preview {
    OperationFormView(
        listViewModel: ListViewModel()
    )
}
