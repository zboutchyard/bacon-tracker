//
//  BudgetOption.swift
//  Pong
//
//  Created by Zack Boutchyard on 4/19/25.
//

import Foundation

struct BudgetOptionItem: Identifiable {
    let id = UUID()
    let title: String
    let subtext: String
    let destination: BudgetTrackerRoute
}

enum BudgetOptions: CaseIterable {
    case trackSpending
    case setMonthlyBudget
    case setSavingsGoal
    
    var item: BudgetOptionItem {
        switch self {
        case .trackSpending:
            return .init(title: "Track Spending", subtext: "Stop the leaks in your piggy bank.", destination: .trackSpending)
        
        case .setMonthlyBudget:
            return .init(title: "Set Monthly Budget", subtext: "Don’t let your budget go hog wild.", destination: .setMonthlyBudget)
            
        case .setSavingsGoal:
            return .init(title: "Set Savings Goal", subtext: "Save up for a new trough.", destination: .setSavingsGoal)
        }
    }
    
    static var allItems: [BudgetOptionItem] {
           return Self.allCases.map { $0.item }
       }
}
