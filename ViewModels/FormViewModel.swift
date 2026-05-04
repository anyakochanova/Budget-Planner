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
    
//  private let storage: OperationsStorageProtocol
    let storage: OperationsStorageProtocol
    var originalOperation: Operation?
    
    init(storage: OperationsStorageProtocol, operation: Operation? = nil) {
        self.storage = storage
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
        guard !newOperationTitle.isEmpty else { return false }
        guard let amount = Double(newOperationAmount) else { return false }
        
        let newOperation = Operation(
            id: originalOperation?.id ?? UUID(),
            type: newOperationType,
            title: newOperationTitle,
            amount: amount,
            date: newOperationDate
        )
        
        if originalOperation == nil {
            storage.addOperation(newOperation)
        } else {
            storage.editOperation(newOperation)
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
