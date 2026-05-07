//
//  AddOperationViewModel.swift.swift
//  Budget
//
//  Created by Anna Kochanova on 26.02.2026.
//

import Foundation
import Combine

class FormViewModel: ObservableObject {
    @Published var newOperationType: OperationType = .income
    @Published var newOperationTitle = ""
    @Published var newOperationAmount = ""
    @Published var newOperationDate = Date()
    
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
    
    deinit {
        print("FormViewModel deinit")
    }   
    
    func save() -> Bool {
//        guard !newOperationTitle.isEmpty else { return false }
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
            }
        } else {
            do {
                try viewModel.editOperation(newOperation)
            } catch {
                print("Storage error::", error)
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
