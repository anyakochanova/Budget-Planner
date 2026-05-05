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
    
    // Initialization
    init() {
        print("MockStorage init")
    }
    
    // Actions
    func editOperation(_ operation: Operation) {
        if let index = operations.firstIndex(where: { $0.id == operation.id }) {
            operations[index] = operation
        }
        print("MockStorage updated: \(operations.count)")
    }
    
    func addOperation(_ operation: Operation) {
        operations.append(operation)
        print("MockStorage updated: \(operations.count)")
    }
    
    func removeOperation(_ operation: Operation) {
        operations.removeAll { $0.id == operation.id }
        print("MockStorage updated: \(operations.count)")
    }
    
    func loadOperations() -> [Operation] {
            operations
    }
}
