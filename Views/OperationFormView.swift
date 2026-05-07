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
    
    init(viewModel: ListViewModel, operation: Operation? = nil) {
        _formViewModel = StateObject(
            wrappedValue: FormViewModel(
                viewModel: viewModel,
                operation: operation
            )
        )
    }
    
    var body: some View {
        VStack {
            Picker("Operation type", selection: $formViewModel.newOperationType) {
                ForEach(OperationType.allCases) { type in
                    Text(type.title).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
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
                if formViewModel.save() {
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
        viewModel: ListViewModel(storage: MockStorage())
    )
}
