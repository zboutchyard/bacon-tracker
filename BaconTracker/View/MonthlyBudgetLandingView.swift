//
//  MonthlyBudgetLandingView.swift
//  Pong
//
//  Created by Zack Boutchyard on 5/12/25.
//

import SwiftUI

struct MonthlyBudgetLandingView: View {
    @Environment(BudgetTrackerCoordinator.self) var coordinator: BudgetTrackerCoordinator
    @State var viewModel: BudgetViewModel = .init()
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Let's get that budget started!")
                    .font(.custom("Fredoka-Bold", size: 30))
                    .foregroundColor(.white)
                Text("How much do you make per month?")
                    .font(.custom("Fredoka-Bold", size: 25))
                    .foregroundColor(.white)
                VStack {
                    TextField(text: $viewModel.monthlyIncome, prompt: Text("Monthly income")) {
                        Text("$")
                    }
                    .textFieldStyle(RoundedTextFieldStyle())
                }
                .padding(.top, 20)
                .keyboardType(.numberPad)
            }
            .padding()
            Spacer()
            bottomButton(viewModel: viewModel)
        }
        .background(Image(.landingViewBackground))
        .navigationBarBackButtonHidden()
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
    
    func bottomButton(viewModel: BudgetViewModel) -> some View {
        Button {
            coordinator.navigate(to: .monthlyBudgetInputView(viewModel: $viewModel))
        } label: {
            VStack {
                Text("Continue")
                    .font(.custom("Fredoka-Bold", size: 25))
            }
            .foregroundColor(.white)
            .padding(.vertical, 24)
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.9, green: 0.3, blue: 0.25))
            .cornerRadius(30)
            .padding()
            
        }
    }
}

#Preview {
    MonthlyBudgetLandingView()
}
