//
//  OperationType.swift
//  Budget
//
//  Created by Anna Kochanova on 25.03.2026.
//

import Foundation

enum OperationType: String, Codable, CaseIterable, Identifiable {
    case income
    case expense

    var id: String { rawValue }

    var title: String {
        switch self {
        case .income: return "Income"
        case .expense: return "Expense"
        }
    }
}
