//
//  TestMockStorage.swift
//  Budget
//
//  Created by Anna Kochanova on 01.07.2026.
//

final class TestMockStorage: OperationsStorageProtocol {
    
    var operations: [Operation] = []
    
    func editOperation(_ operation: Operation) throws {
        if let index = operations.firstIndex(where: { $0.id == operation.id }) {
            operations[index] = operation
        }
    }
    
    func addOperation(_ operation: Operation) throws {
        operations.append(operation)
    }
    
    func removeOperation(_ operation: Operation) {
        operations.removeAll { $0.id == operation.id }
    }
    
    func loadOperations() -> [Operation] {
        operations
    }
}
