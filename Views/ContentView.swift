//
//  ContentView.swift
//  Budget
//
//  Created by Anna Kochanova on 09.02.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if isLoggedIn {
                    LoggedInView(handleLogout: {
                        isLoggedIn = false
                    })
                } else {
                    LoginView(handleLogin: {
                        isLoggedIn = true
                    })
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
