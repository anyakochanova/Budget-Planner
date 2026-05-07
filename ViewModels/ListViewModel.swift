//
//  OperationsViewModel.swift
//  Budget
//
//  Created by Anna Kochanova on 19.02.2026.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    
    // Data state
    // private(set) – читать можно отовсюду, а изменять только внутри файла/класса
    @Published private(set) var operations: [Operation] = []
    @Published var showOnlyExpenses = false
    
    private let storage: OperationsStorageProtocol
    private let operationsKey = "operations"
    
    // Initialization
    init(storage: OperationsStorageProtocol) {
        self.storage = storage
        self.operations = storage.loadOperations()
    }
    
    deinit {
        print("ListViewModel deinit")
    }
    
    // Computed properties
    var filteredOperations : [Operation] {
        if showOnlyExpenses {
            operations.filter { $0.type == .expense }
        } else {
            operations
        }
    }
    
    var totalBalance: Double {
        operations.map { $0.amount }.reduce(0, +)
    }
    
    var expenses: Double {
        operations
            .filter { $0.type == .expense }
            .map { $0.amount }
            .reduce(0, +)
    }
    
    var incomes: Double {
        operations
            .filter { $0.type == .income }
            .map { $0.amount }
            .reduce(0, +)
    }
    
    // Actions
    func editOperation(_ operation: Operation) throws {
        try storage.editOperation(operation)
        operations = storage.loadOperations()
    }
    
    func addOperation(_ operation: Operation) throws {
        try storage.addOperation(operation)
        operations = storage.loadOperations()
    }
    
    func removeOperation(_ operation: Operation) {
        storage.removeOperation(operation)
        operations = storage.loadOperations()
    }
}
