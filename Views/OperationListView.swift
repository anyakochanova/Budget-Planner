//
//  OperationListView.swift
//  Budget
//
//  Created by Anna Kochanova on 09.02.2026.
//

import SwiftUI

struct OperationListView: View {
    @State private var showAddSheet = false
    @StateObject private var viewModel = ListViewModel()

    var body: some View {
        VStack {
            Toggle("Show only expenses",
                   isOn: $viewModel.showOnlyExpenses)
                .padding()
            
            Text("Balance: \(viewModel.totalBalance, format: .currency(code: "RUB"))")
            
            Text("Expenses: \(viewModel.expenses, format: .currency(code: "RUB"))")
            
            List {
                ForEach(viewModel.filteredOperations) { operation in
                    NavigationLink {
                        OperationDetailView(
                            viewModel: viewModel,
                            operation: operation         
                        )
                    } label: {
                        OperationRowView(operation: operation)
                    }
                }
            }
            
            Button("Add operation") {
                showAddSheet = true
            }
            
            .sheet(isPresented: $showAddSheet) {
                OperationFormView(
                    listViewModel: viewModel
                )
            }
        }
    }
}

#Preview {
    OperationListView()
}
