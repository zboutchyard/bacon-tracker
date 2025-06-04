//
//  Expense.swift
//  Pong
//
//  Created by Zack Boutchyard on 5/31/25.
//

import Foundation

struct Expense: Identifiable, Equatable {
    var id: UUID = UUID()
    var memo: String
    var amount: Double
    var date: Date
    var expenseClassification: ExpenseClassification
}

enum ExpenseClassification: String, CaseIterable {
    case transportation = "Transportation"
    case other = "Other"
    case entertainment = "Entertainment"
    case rent = "Rent"
    case dining = "Dining"
    case grocery = "Grocery"
    case healthcare = "Healthcare"
    case education = "Education"
    case utility = "Utility"
    case creditCard = "Credit Card"
}

