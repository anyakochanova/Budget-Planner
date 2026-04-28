//
//  OperationsStorageProtocol.swift
//  Budget
//
//  Created by Anna Kochanova on 26.03.2026.
//

import Foundation

protocol OperationsStorageProtocol {
    func editOperation(_ operation: Operation)
    func addOperation(_ operation: Operation)
    func removeOperation(_ operation: Operation)
    func loadOperations() -> [Operation]
}
