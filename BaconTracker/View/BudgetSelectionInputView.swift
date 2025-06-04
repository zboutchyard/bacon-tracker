//
//  BudgetSelectionInputView.swift
//  Pong
//
//  Created by Zack Boutchyard on 5/13/25.
//

import SwiftUI

struct BudgetSelectionInputView: View {
    @Binding var viewModel: BudgetViewModel
    @Environment(BudgetTrackerCoordinator.self) var coordinator: BudgetTrackerCoordinator
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: Binding<BudgetViewModel>) {
        self._viewModel = viewModel
    }
    var body: some View {
        VStack {
            if case .error = viewModel.loadingState {
                ErrorView()
                    .transition(.slide)
            }
            VStack {
                topSection
                if !viewModel.expenseArray.isEmpty {
                    listContent
                }
                addButton
            }
            .sheet(isPresented: $viewModel.shouldShowAddExpenseView, content: {
                AddExpenseSheetView(viewModel: viewModel)
            })
            .padding()
            Spacer()
            bottomButton
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
    
    var listContent: some View {
        List {
            ForEach(viewModel.expenseArray) { expense in
                Button {
                    Task {
                        coordinator.navigate(to: .editExpenseView(viewModel, expense))
                    }
                } label: {
                    HStack {
                        VStack {
                            Text(expense.memo)
                            Text(expense.expenseClassification.rawValue)
                        }
                        Spacer()
                        VStack {
                            Text("$\(expense.amount, specifier: "%.2f")")
                            Text("\(expense.date.formatted(date: .numeric, time: .omitted))")
                        }
                        Image(systemName: "chevron.right")
                    }
                }
                .buttonStyle(.plain)
            }
            .onDelete { offset in
                viewModel.expenseArray.remove(atOffsets: offset)
            }
        }
        .toolbar {
            EditButton()
                .foregroundStyle(.white)
        }
        .scrollContentBackground(.hidden)
    }
    
    var topSection: some View {
        Text("Let's add your expenses.")
            .font(.custom("Fredoka-Bold", size: 30))
            .foregroundColor(.white)
    }
    
    var addButton: some View {
        Button {
            viewModel.shouldShowAddExpenseView.toggle()
        } label: {
            VStack {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
            }
            .foregroundColor(.white)
            .padding(.vertical, 24)
            .padding(.horizontal, 40)
            .frame(width: 100, height: 100)
            .background(Color(red: 0.9, green: 0.3, blue: 0.25))
            .cornerRadius(30)
            .padding()
        }
    }
    
    var bottomButton: some View {
        Button {
            coordinator.navigate(to: .reviewConfirmExpenseView(viewModel))
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
    struct PreviewWrapper: View {
        @State var viewModel = BudgetViewModel()

        var body: some View {
            BudgetSelectionInputView(viewModel: $viewModel)
                .environment(BudgetTrackerCoordinator())
        }
    }

    return PreviewWrapper()
}
