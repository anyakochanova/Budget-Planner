//
//  OperationsViewModel.swift
//  Budget
//
//  Created by Anna Kochanova on 19.02.2026.
//

import Foundation
import Combine

@MainActor
class ListViewModel: ObservableObject {
    
    // Data state
    // private(set) – читать можно отовсюду, а изменять только внутри файла/класса
    @Published private(set) var operations: [Operation] = []
    @Published var isLoading: Bool = false
    @Published var showOnlyExpenses = false
    
    private let storage: OperationsStorageProtocol
    
    // Initialization
    init(storage: OperationsStorageProtocol) {
        self.storage = storage
        self.operations = []
    }
    
    // Computed properties
    var filteredOperations : [Operation] {
        if showOnlyExpenses {
            operations.filter { $0.type == .expense }
        } else {
            operations
        }
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
    
    var totalBalance: Double {
        incomes - expenses
    }
    
    // Actions
    func loadOperations() async {
        isLoading = true
        
        try? await Task.sleep(for: .seconds(1))
        operations = storage.loadOperations()
        
        isLoading = false
    }
    
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
