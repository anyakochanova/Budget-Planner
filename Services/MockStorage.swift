//
//  MockStorage.swift
//  Budget
//
//  Created by Anna Kochanova on 27.04.2026.
//

import Foundation
import Combine

final class MockStorage: OperationsStorageProtocol {
    // Data state
    // private(set) – читать можно отовсюду, а изменять только внутри файла/класса
    private(set) var operations: [Operation] = [
        Operation(type: .income, title: "Mock salary", amount: 1000, date: Date()),
        Operation(type: .expense, title: "Mock food", amount: -200, date: Date())
    ]
    
    // Actions 
    func editOperation(_ operation: Operation) {
        if let index = operations.firstIndex(where: { $0.id == operation.id }) {
            operations[index] = operation
        }
    }
    
    func addOperation(_ operation: Operation) {
        operations.append(operation)
    }
    
    func removeOperation(_ operation: Operation) {
        operations.removeAll { $0.id == operation.id }
    }
    
    func loadOperations() -> [Operation] {
            operations
    }
}
