//
//  BudgetTrackerCoordinator.swift
//  Pong
//
//  Created by Zack Boutchyard on 4/19/25.
//

import SwiftUI

enum BudgetTrackerRoute: Hashable {
    static func == (lhs: BudgetTrackerRoute, rhs: BudgetTrackerRoute) -> Bool {
        switch (lhs, rhs) {
        case (.monthlyBudgetInputView, .monthlyBudgetInputView):
            return true
        default: return lhs.hashValue == rhs.hashValue
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .monthlyBudgetInputView:
            hasher.combine("monthlyBudgetInputView")
        default:
            hasher.combine("some other value")
        }
    }
    
    case landingView
    case optionView
    case trackSpending
    case setMonthlyBudget
    case setSavingsGoal
    case monthlyBudgetSavingsGoal
    case monthlyBudgetInputView(viewModel: Binding<BudgetViewModel>)
    case editExpenseView(BudgetViewModel, Expense)
    case reviewConfirmExpenseView(BudgetViewModel)
    case budgetOverview(BudgetViewModel)
}

@Observable class BudgetTrackerCoordinator {
    var path = NavigationPath()
    
    func navigate(to route: BudgetTrackerRoute) {
        path.append(route)
    }
    
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func view(for route: BudgetTrackerRoute) -> some View {
        switch route {
        case .landingView:
            BudgetTrackerLandingView()
        case .trackSpending:
            EmptyView()
        case .setMonthlyBudget:
            MonthlyBudgetLandingView()
        case .setSavingsGoal:
            EmptyView()
        case .optionView:
            OptionsView()
        case .monthlyBudgetSavingsGoal:
            EmptyView()
        case .monthlyBudgetInputView(let viewModel):
            BudgetSelectionInputView(viewModel: viewModel)
        case .editExpenseView(let viewModel, let expense):
            EditExpenseView(viewModel: viewModel, expense: expense)
        case .reviewConfirmExpenseView(let viewModel):
            ReviewConfirmExpenseView(viewModel: viewModel)
        case .budgetOverview(let viewModel):
            BudgetOverview(viewModel: viewModel)
        }
    }
}
