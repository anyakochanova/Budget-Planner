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
        VStack(spacing: 20) {
            
            // Operation
            VStack(spacing: 12) {
                
                Text(operation.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(operation.amount, format: .currency(code: "RUB"))
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundStyle(operation.type == .expense ? .red : .green)
                
                Text(operation.date, format: .dateTime.day().month().year())
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .padding(.horizontal)
            
            // Edit button
            Button("Edit") {
                showEditSheet = true
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
            
            // Delete button
            Button(role: .destructive) {
                viewModel.removeOperation(operation)
                dismiss()
            } label: {
                Text("Delete")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .padding(.horizontal)
                        
            Spacer()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showEditSheet) {
            OperationFormView(
                viewModel: viewModel,
                operation: operation
            )
        }
    }
}

#Preview {
    OperationDetailView(
        viewModel: ListViewModel(storage: MockStorage()),
        operation: Operation(
            type: OperationType.expense,
            title: "Food",
            amount: -40,
            date: Date()
        )
    )
}
