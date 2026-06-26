//
//  AddOperationViewModel.swift.swift
//  Budget
//
//  Created by Anna Kochanova on 26.02.2026.
//

import Foundation
import Combine

@MainActor
class FormViewModel: ObservableObject {
    @Published var newOperationType: OperationType = .income
    @Published var newOperationTitle = ""
    @Published var newOperationAmount = ""
    @Published var newOperationDate = Date()
    
    @Published var errorMessage = ""
    @Published var showErrorAlert = false
    
    let viewModel: ListViewModel
    var originalOperation: Operation?
    
    init(viewModel: ListViewModel, operation: Operation? = nil) {
        self.viewModel = viewModel
        self.originalOperation = operation
        
        if let operation {
            newOperationType = operation.type
            newOperationTitle = operation.title
            newOperationAmount = String(operation.amount)
            newOperationDate = operation.date
        }
    }
    
    func save() -> Bool {
        guard let amount = Double(newOperationAmount) else { return false }
        	
        let newOperation = Operation(
            id: originalOperation?.id ?? UUID(),
            type: newOperationType,
            title: newOperationTitle,
            amount: amount,
            date: newOperationDate
        )
        
        if originalOperation == nil {
            do {
                try viewModel.addOperation(newOperation)
            } catch {
                print("Storage error::", error)
                errorMessage = "Storage error: \(error)"
                showErrorAlert = true
            }
        } else {
            do {
                try viewModel.editOperation(newOperation)
            } catch {
                print("Storage error::", error)
                errorMessage = "Storage error: \(error)"
                showErrorAlert = true
            }
        }
        
        clearForms()
        return true
    }
    
    private func clearForms() {
        newOperationType = OperationType.income
        newOperationTitle = ""
        newOperationAmount = ""
        newOperationDate = Date()
    }
}
