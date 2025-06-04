//
//  AddExpenseSheetView.swift
//  Pong
//
//  Created by Zack Boutchyard on 5/14/25.
//

import SwiftUI

struct AddExpenseSheetView: View {
    var viewModel: BudgetViewModel
    @State var memo: String = ""
    @State var amount: String = ""
    @State var date: Date = Date()
    let classification: BudgetTypeClassification = BudgetTypeClassification()
    
    init(viewModel: BudgetViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Memo:")
                Spacer()
                TextField("", text: $memo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: 200)
                    .foregroundStyle(.black)
            }
            HStack {
                Text("Amount:")
                Spacer()
                TextField("", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.decimalPad)
                    .frame(maxWidth: 200)
                    .foregroundStyle(.black)
            }
            HStack {
                Text("Date:")
                Spacer()
                DatePicker("date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.compact)
            }
            Spacer()
            Button {
                if !memo.isEmpty && !amount.isEmpty {
                    viewModel.expense = Expense(
                        memo: memo,
                        amount: Double(amount) ?? 0,
                        date: date,
                        expenseClassification: ExpenseClassification(
                            rawValue: classification.classify(memo)
                        ) ?? .other)
                    viewModel.appendExpense()
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
        .font(.custom("Fredoka-Bold", size: 30))
        .foregroundColor(.white)
        .background(Image(.landingViewBackground))
    }
}
