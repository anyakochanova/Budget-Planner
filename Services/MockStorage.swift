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
        Operation(type: .income, title: "Salary", amount: 100000, date: Date()),
        Operation(type: .expense, title: "Groceries", amount: 2000, date: Date()),
        Operation(type: .expense, title: "Coffee", amount: 500, date: Date()),
        Operation(type: .expense, title: "Transport", amount: 1500, date: Date())
    ]
    
    // Actions
    func editOperation(_ operation: Operation) throws {
        if operation.title.isEmpty {
            throw StorageError.emptyTytle
        }
        
        if operation.amount == 0 || operation.amount < 0 {
            throw StorageError.invalidAmount
        }
        
        if let index = operations.firstIndex(where: { $0.id == operation.id }) {
            operations[index] = operation
        }
        print("MockStorage updated: \(operations.count)")
    }
    
    func addOperation(_ operation: Operation) throws {
        if operation.title.isEmpty {
            throw StorageError.emptyTytle
        }
        
        if operation.amount == 0 || operation.amount < 0 {
            throw StorageError.invalidAmount
        }
        
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
