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
    @Published var newOperationDate = ""
    
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
    
    func save() {
        let newOperation = Operation(
            id: originalOperation?.id ?? UUID(),
            title: newOperationTitle,
            amount: Double(newOperationAmount) ?? 0.0,
            date: newOperationDate
        )
        
        if originalOperation == nil {
            listViewModel.addOperation(newOperation)
        } else {
            listViewModel.editOperation(newOperation)
        }
        
        clearForms()
    }
    
    private func clearForms() {
        newOperationTitle = ""
        newOperationAmount = ""
        newOperationDate = ""
    }
}
