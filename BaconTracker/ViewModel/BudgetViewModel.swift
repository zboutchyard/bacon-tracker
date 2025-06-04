//
//  BudgetViewModel.swift
//  Pong
//
//  Created by Zack Boutchyard on 5/13/25.
//

import Foundation

enum LoadingState {
    case loading
    case idle
    case loaded
    case error(String)
}

@Observable
class BudgetViewModel {
    var expense: Expense? = nil
    var monthlyIncome: String = "0.00"
    var expenseArray: [Expense] = [Expense(memo: "monthly rent",
                                                      amount: 2000,
                                                      date: Date(timeIntervalSince1970: 0), expenseClassification: .creditCard)]
    var shouldShowAddExpenseView: Bool = false
    var loadingState: LoadingState = .idle
    var totalExpenses: Double {
        return expenseArray.reduce(0) { $0 + $1.amount }
    }
    
    func appendExpense() {
        loadingState = .loading
        if let expense = expense {
            expenseArray.append(expense)
            self.expense = nil
            shouldShowAddExpenseView = false
            loadingState = .loaded
        } else {
            loadingState = .error("Something went wrong")
        }
    }
    
    func replaceExpense(expenseToRemove: Expense) {
        let expenseIndex: Int = expenseArray.firstIndex(where: { $0.id == expenseToRemove.id }) ?? 0
        expenseArray.removeAll { $0.id == expenseToRemove.id }
        expenseArray.insert(expenseToRemove, at: expenseIndex)
    }
}
