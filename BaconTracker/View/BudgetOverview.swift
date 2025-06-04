//
//  BudgetOverview.swift
//  Pong
//
//  Created by Zack Boutchyard on 6/2/25.
//

import Charts
import SwiftUI

struct BudgetOverview: View {
    var viewModel: BudgetViewModel
    @State private var selectedCount: Int?
    @State private var selectedSector: Expense?
    @Environment(BudgetTrackerCoordinator.self) var coordinator: BudgetTrackerCoordinator
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Here's a breakdown of your budget")
                    .font(.custom("Fredoka-Bold", size: 25))
                    .foregroundColor(.white)
                Text("Your take home: $\(viewModel.monthlyIncome)")
                    .font(.custom("Fredoka-Bold", size: 20))
                    .foregroundColor(.white)
                Text("Total expenses: $\(viewModel.totalExpenses, specifier: "%.2f")")
                    .font(.custom("Fredoka-Bold", size: 20))
                    .foregroundColor(.white)
                if let income = viewModel.monthlyIncome.toDouble {
                    Text("Money left over: $\(income - viewModel.totalExpenses, specifier: "%.2f")")
                        .font(.custom("Fredoka-Bold", size: 20))
                        .foregroundColor(.white)
                }
            }
            chartView
            if let expense = selectedSector {
                VStack {
                    Text("Memo: \(expense.memo)")
                    Text("Amount: \(expense.amount)")
                    Text("Transaction Date: \(expense.date.formatted(date: .abbreviated, time: .omitted))")
                }
                .font(.custom("Fredoka-Bold", size: 20))
                .foregroundColor(.white)
            }
        }
        .padding()
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
    
    var chartView: some View {
        Chart {
            ForEach(viewModel.expenseArray) { expense in
                SectorMark(angle: .value("budget", expense.amount),
                           innerRadius: .ratio(0.65),
                           angularInset: 2.0)
                .opacity(selectedSector == nil ? 1.0 : (selectedSector == expense ? 1.0 : 0.5))
                .foregroundStyle(by: .value("Type", expense.memo))
                .cornerRadius (10.0)
                .annotation (position: .overlay) {
                    VStack {
                        Text(expense.memo)
                        Text("$\(expense.amount, specifier: "%.2f")")
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                }
            }
        }
        .onChange(of: selectedCount) { oldValue, newValue in
            if let newValue {
                selectedSector = findSelectedSector(value: newValue)
            }
        }
        .chartAngleSelection(value: $selectedCount)
        .chartLegend(.hidden)
        .chartBackground { proxy in
            Image("LandingViewPiggie")
                .resizable()
                .scaledToFit()
        }
    }
    
    private func findSelectedSector(value: Int) -> Expense? {
        var accumulated = 0

        for expense in viewModel.expenseArray {
            let slice = expenseAmount(expense)
            accumulated += slice
            if value < accumulated {
                return expense
            }
        }

        return nil
    }

    private func expenseAmount(_ expense: Expense) -> Int {
        Int(expense.amount.rounded())
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var viewModel = BudgetViewModel()

        var body: some View {
            BudgetOverview(viewModel: viewModel)
                .environment(BudgetTrackerCoordinator())
                .task {
                    viewModel.monthlyIncome = "3000.00"
                }
        }
    }

    return PreviewWrapper()
}
