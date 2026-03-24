//
//  OperationDetailView.swift
//  Budget
//
//  Created by Anna Kochanova on 09.02.2026.
//

import SwiftUI

struct OperationDetailView: View {    
    @Environment(\.dismiss) private var dismiss
    @State private var showEditSheet = false
    @ObservedObject var viewModel: ListViewModel    
    
    let operation: Operation
    
    var body: some View {
        VStack {
            Text("""
                \(operation.title)
                \(operation.amount, format: .currency(code: "RUB"))
                \(operation.date)
                """)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
            
            Button("Edit operation") {
                showEditSheet = true
            }
            
            .sheet(isPresented: $showEditSheet) {
                OperationFormView(
                    listViewModel: viewModel,
                    operation: operation
                )
            }
            
            Button("Remove operation") {
                viewModel.removeOperation(operation)
                dismiss()
            }
        }
        .frame(width: 250)
    }
}

#Preview {
    OperationDetailView(
        viewModel: ListViewModel(),
        operation: Operation(
            title: "Food",
            amount: -40,
            date: Date()
        )        
    )
}
