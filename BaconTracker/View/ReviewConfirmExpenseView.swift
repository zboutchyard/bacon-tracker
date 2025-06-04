//
//  ReviewConfirmExpenseView.swift
//  Pong
//
//  Created by Zack Boutchyard on 6/1/25.
//

import SwiftUI
import Charts

struct ReviewConfirmExpenseView: View {
    var viewModel: BudgetViewModel
    @Environment(BudgetTrackerCoordinator.self) var coordinator: BudgetTrackerCoordinator
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: BudgetViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Now let's review")
                .font(.custom("Fredoka-Bold", size: 30))
                .foregroundColor(.white)
                .padding(.top)
            List {
                ForEach(viewModel.expenseArray) { expense in
                    HStack {
                        VStack {
                            Text(expense.memo)
                            Text("$\(expense.amount, specifier: "%.2f")")
                        }
                        Spacer()
                        VStack {
                            Text(expense.date.formatted(date: .numeric, time: .omitted))
                        }
                    }
                    .padding()
                }
            }
            bottomButton
        }
        .background(Image(.landingViewBackground))
        .scrollContentBackground(.hidden)
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
    
    var bottomButton: some View {
        Button {
            coordinator.navigate(to: .budgetOverview(viewModel))
        } label: {
            VStack {
                Text("Looks good!")
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
    @Previewable @Environment(BudgetTrackerCoordinator.self) var coordinator: BudgetTrackerCoordinator
    ReviewConfirmExpenseView(viewModel: BudgetViewModel())
}
