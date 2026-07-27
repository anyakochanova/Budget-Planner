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
            if isLoggedIn {
                LoggedInView {
                    isLoggedIn = false
                }
            } else {
                LoginView {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
