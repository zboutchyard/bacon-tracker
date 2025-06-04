//
//  EditExpenseView.swift
//  Pong
//
//  Created by Zack Boutchyard on 5/31/25.
//

import SwiftUI

struct EditExpenseView: View {
    @State var expense: Expense
    var viewModel: BudgetViewModel
    @Environment(BudgetTrackerCoordinator.self) var coordinator: BudgetTrackerCoordinator
    let classification: BudgetTypeClassification = BudgetTypeClassification()
    let allExpenseClassifications: [ExpenseClassification] = .init(ExpenseClassification.allCases)
    @Environment(\.dismiss) var dismiss
    
    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    init(viewModel: BudgetViewModel, expense: Expense) {
        self.viewModel = viewModel
        self.expense = expense
    }

    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Memo:")
                    Spacer()
                    TextField("", text: $expense.memo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(maxWidth: 200)
                        .foregroundStyle(.black)
                }
                HStack {
                    Text("Amount:")
                    Spacer()
                    TextField("Amount", value: $expense.amount, formatter: currencyFormatter)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .keyboardType(.decimalPad)
                        .frame(maxWidth: 200)
                        .foregroundStyle(.black)
                }
                HStack {
                    Picker(selection: $expense.expenseClassification, label: Text("Budget Type:")) {
                        ForEach(allExpenseClassifications, id: \.self) { classification in
                            Text(classification.rawValue).tag(classification.rawValue)
                        }
                    }
                }
                HStack {
                    Text("Date:")
                    Spacer()
                    DatePicker("", selection: $expense.date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
            }
            .font(.custom("Fredoka-Bold", size: 18))
            .scrollContentBackground(.hidden)
            .background(Image(.landingViewBackground))
            Button {
                if !expense.memo.isEmpty {
                    viewModel.expense = Expense(
                        memo: expense.expenseClassification.rawValue,
                        amount: expense.amount,
                        date: expense.date,
                        expenseClassification: expense.expenseClassification)
                    viewModel.replaceExpense(expenseToRemove: expense)
                    dismiss()
                }
            } label: {
                VStack {
                    Text("Submit")
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
}
