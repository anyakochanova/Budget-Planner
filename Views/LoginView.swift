//
//  LoginView.swift
//  Budget
//
//  Created by Anna Kochanova on 11.02.2026.
//

import SwiftUI

struct LoginView: View {
    let handleLogin: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text("Login screen")
                .font(.title)

            Button("Log in") {
                handleLogin()
            }
        }
    }
}

#Preview {
    LoginView(handleLogin: {})
}

