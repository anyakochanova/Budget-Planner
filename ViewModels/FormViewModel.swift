//
//  AddOperationViewModel.swift.swift
//  Budget
//
//  Created by Anna Kochanova on 26.02.2026.
//

import Foundation
import Combine

class FormViewModel: ObservableObject {
    @Published var newOperationTitle = ""
    @Published var newOperationAmount = ""
    @Published var newOperationDate = Date()
    @Published var newOperationType: OperationType = .income
    
    private let listViewModel: ListViewModel
    var originalOperation: Operation?
    
    init(listViewModel: ListViewModel, operation: Operation? = nil) {
        self.listViewModel = listViewModel
        self.originalOperation = operation
        
        if let operation {
            newOperationTitle = operation.title
            newOperationAmount = String(operation.amount)
            newOperationDate = operation.date
        }
    }
    
    func save() -> Bool {
        guard !newOperationTitle.isEmpty else { return false }
        guard let amount = Double(newOperationAmount) else { return false }
        
        let newOperation = Operation(
            id: originalOperation?.id ?? UUID(),
            title: newOperationTitle,
            amount: amount,
            date: newOperationDate,
            type: newOperationType
        )
        
        if originalOperation == nil {
            listViewModel.addOperation(newOperation)
        } else {
            listViewModel.editOperation(newOperation)
        }
        
        clearForms()
        return true
    }
    
    private func clearForms() {
        newOperationTitle = ""
        newOperationAmount = ""
        newOperationDate = Date()
        newOperationType = OperationType.income
    }
}
