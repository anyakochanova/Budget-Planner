//
//  OperationListView.swift
//  Budget
//
//  Created by Anna Kochanova on 09.02.2026.
//

import SwiftUI

struct OperationListView: View {
    let handleLogout: () -> Void
    
    @State private var showAddSheet = false
    @StateObject private var viewModel = ListViewModel(storage: MockStorage())

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                
                // Summary
                VStack(alignment: .leading, spacing: 6) {
                    Text("Balance: \(viewModel.totalBalance, format: .currency(code: "RUB"))")
                    Text("Expenses: \(viewModel.expenses, format: .currency(code: "RUB"))")
                }
                .padding(.horizontal)
                
                // Filter
                Toggle("Show only expenses",
                       isOn: $viewModel.showOnlyExpenses)
                .padding(.horizontal)
                
                // Operations
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
                .listStyle(.plain)
                
                Spacer(minLength: 0)
            }
            
            // Loading overlay
            if viewModel.isLoading {
                ProgressView()
            }
        }
        
        // Add, log out buttons
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Log out") {
                    handleLogout()
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    showAddSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    
        .sheet(isPresented: $showAddSheet) {
            OperationFormView(viewModel: viewModel)
        }
        
        .task {
            await viewModel.loadOperations()
        }
    }
}

#Preview {
    NavigationStack {
        OperationListView(handleLogout: {})
    }
}
