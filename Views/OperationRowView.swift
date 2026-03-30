//
//  Untitled.swift
//  Budget
//
//  Created by Anna Kochanova on 12.02.2026.
//

import SwiftUI

struct OperationRowView: View {
    let operation: Operation
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(operation.title)
                Text(operation.date, format: .dateTime.day().month().year())
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Text("\(operation.amount, format: .currency(code: "RUB"))")
                .foregroundStyle(operation.type == .expense ? .red : .green)
        }
        .padding(.vertical, 4)
    }
}


#Preview {
    OperationRowView(
        operation: Operation(
            type: OperationType.expense,
            title: "Food",
            amount: -40,
            date: Date()
        )
    )
}


