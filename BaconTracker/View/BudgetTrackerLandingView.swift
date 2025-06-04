//
//  BudgetTrackerLandingView.swift
//  Pong
//
//  Created by Zack Boutchyard on 4/19/25.
//

import SwiftUI

struct BudgetTrackerLandingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var coordinator = BudgetTrackerCoordinator()
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack(spacing: 10) {
                Text("BACON TRACKER")
                    .font(.custom("Fredoka-Bold", size: 70))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                Image(.landingViewPiggie)
                    .resizable()
                    .frame(maxWidth: 400, maxHeight: 300)
                Button {
                    coordinator.navigate(to: .optionView)
                } label: {
                    Text("GET STARTED")
                        .font(.custom("Fredoka-Bold", size: 25))
                        .foregroundColor(.white)
                        .padding(.vertical, 24)
                        .padding(.horizontal, 40)
                        .background(Color(red: 0.9, green: 0.3, blue: 0.25))
                        .cornerRadius(30)
                }
                .shadow(radius: 4)
            }
            .background(Image(.landingViewBackground))
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.white)
                        
                    }

                }
            })
            .navigationDestination(for: BudgetTrackerRoute.self) { route in
                coordinator.view(for: route)
            }
        }
        .environment(coordinator)
    }
}

#Preview {
    BudgetTrackerLandingView()
}
