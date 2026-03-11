//
//  Operation.swift
//  Budget
//
//  Created by Anna Kochanova on 12.02.2026.
//

import Foundation

struct Operation: Identifiable, Codable {
    let id: UUID
    let title: String
    let amount: Double
    let date: String
    
    init(id: UUID = UUID(), title: String, amount: Double, date: String) {
        self.id = id
        self.title = title
        self.amount = amount
        self.date = date
    }
}
