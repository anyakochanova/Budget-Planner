//
//  LoggedInView.swift
//  Budget
//
//  Created by Anna Kochanova on 11.02.2026.
//

import SwiftUI

struct LoggedInView: View {
    let handleLogout: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            OperationListView()

            Button("Log out") {
                handleLogout()
            }
        }
    }
}

#Preview {
    LoggedInView(handleLogout: {})
}
