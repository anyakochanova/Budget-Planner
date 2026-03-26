//
//  OperationsViewModel.swift
//  Budget
//
//  Created by Anna Kochanova on 19.02.2026.
//

import Foundation
import Combine

class ListViewModel: ObservableObject, OperationsStorageProtocol {
    
    // Data state
    @Published private(set) var operations: [Operation] = [] {
        didSet {
            save()
        }
    }
    
    @Published var showOnlyExpenses = false
    
    private let operationsKey = "operations"
    
    // Initialization
    init() {
        load()
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
    
    func save() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(operations) {
            UserDefaults.standard.set(data, forKey: operationsKey)
        }
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: operationsKey)
        else { return }
        
        let decoder = JSONDecoder()
        
        if let decodedOperations = try? decoder.decode([Operation].self, from: data) {
            operations = decodedOperations
        }
    }
}
