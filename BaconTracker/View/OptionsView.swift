//
//  OptionsView.swift
//  Pong
//
//  Created by Zack Boutchyard on 4/19/25.
//

import SwiftUI

struct OptionsView: View {
    @Environment(BudgetTrackerCoordinator.self) var coordinator: BudgetTrackerCoordinator
    let options: [BudgetOptions] = [.setMonthlyBudget, .setSavingsGoal, .trackSpending]
    var body: some View {
        VStack(spacing: 24) {
            Text("How do you want to start?")
                .font(.custom("Fredoka-Bold", size: 25))
                .foregroundStyle(.white)
            VStack(spacing: 24) {
                ForEach(options, id: \.self) { option in
                    OptionButtonView(title: option.item.title, subtext: option.item.subtext, destination: option.item.destination)
                }
            }
            .padding(.horizontal, 32)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        coordinator.goBack()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.white)
                    }

                }
            }
        }
        .background(Image(.landingViewBackground))
        .navigationBarBackButtonHidden()
    }
}

struct OptionButtonView: View {
    @Environment(BudgetTrackerCoordinator.self) var coordinator: BudgetTrackerCoordinator
    let title: String
    let subtext: String
    let destination: BudgetTrackerRoute

    var body: some View {
        Button {
            coordinator.navigate(to: destination)
        } label: {
            VStack {
                Text(title)
                    .font(.custom("Fredoka-Bold", size: 25))
                Text(subtext)
                    .font(.custom("Fredoka-SemiBold", size: 16))
            }
            .foregroundColor(.white)
            .padding(.vertical, 24)
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.9, green: 0.3, blue: 0.25))
            .cornerRadius(30)
        }
    }
}

#Preview {
    OptionsView()
}
