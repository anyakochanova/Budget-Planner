//
//  Operation.swift
//  Budget
//
//  Created by Anna Kochanova on 12.02.2026.
//

import Foundation

struct Operation: Identifiable, Codable {
    let id: UUID
    let type: OperationType
    let title: String
    let amount: Double
    let date: Date
    
    init(id: UUID = UUID(), type: OperationType, title: String, amount: Double, date: Date) {
        self.id = id
        self.type = type
        self.title = title
        self.amount = amount
        self.date = date
    }
}
