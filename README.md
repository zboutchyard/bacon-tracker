---

# 🥓 Bacon Tracker

A beautifully simple budget tracking app built with **SwiftUI** and **MVVM+C (Model-View-ViewModel + Coordinator)** architecture. Bacon Tracker lets users easily track their income and expenses while using on-device **machine learning** to intelligently classify spending based on memo entries.

<div align="center">
  <img src="https://github.com/user-attachments/assets/2e870b12-6469-4e19-9bf9-22267947699a" width="200">
  <img src="https://github.com/user-attachments/assets/bb1bf416-73b0-411c-bc47-a3a7e02f339f" width="200">
  <img src="https://github.com/user-attachments/assets/5a64974b-9851-449f-967b-be5d8e04da05" width="200">
  <img src="https://github.com/user-attachments/assets/a7fd5bb2-b9b5-41dd-9b02-32046d5d0993" width="200">
  <img src="https://github.com/user-attachments/assets/c50dadc7-6279-40f2-a009-08caa658c9b9" width="200">
  <img src="https://github.com/user-attachments/assets/21cb5393-4252-434f-bb1e-badaeee371ad" width="200">
</div>

---

## ✨ Features

* 🧠 **ML-Powered Memo Classification**
  Uses CoreML to classify entered memos (e.g. "Target", "Gas", "Netflix") into expense categories like Groceries, Utilities, Entertainment, and more.

* 📊 **Pie Chart Visualization**
  Provides a visual breakdown of your spending using Swift Charts’ `SectorMark`.

* 💡 **Clean Navigation via Coordinator**
  Decouples view logic and flow using the MVVM+C pattern, making the app easy to scale and test.

* 🧾 **Inline Editing of Expenses**
  Edit memo, amount, budget type, and date all in a clean, user-friendly form.

* 📁 **Persistent State with ViewModels**
  ViewModels track user state and control UI logic without being tied to the view layer.

---

## 🧱 Architecture

### MVVM+C (Model-View-ViewModel + Coordinator)

* **Model:** `Expense`, `ExpenseClassification`
* **ViewModel:** `BudgetViewModel` handles business logic and state
* **Coordinator:** `BudgetTrackerCoordinator` controls flow between views
* **View:** SwiftUI-powered screens like `BudgetOverview`, `EditExpenseView`, `BudgetSelectionInputView`

---

## 🧠 Machine Learning Integration

* Trained with a custom CoreML `TextClassifier` model
* Takes memo input (e.g. `"Shell Gas"`) and classifies it into an `ExpenseClassification`
* If classification confidence is low, falls back to `.other`

---

## 📷 UI Flow

1. **Landing Page:** Welcomes the user and prompts them to get started
2. **Budget Options:** User chooses to set a budget, savings goal, or track spending
3. **Income Entry:** User inputs their monthly income
4. **Expense Entry:** Add memos and amounts; categories are predicted automatically
5. **Budget Overview:** Beautiful pie chart shows where money is going and what’s left

---

## 🛠️ Tech Stack

* **SwiftUI** – declarative UI
* **CoreML + NLModel** – natural language classification
* **Swift Charts** – pie chart breakdown
* **MVVM + Coordinator** – scalable architecture
* **Custom Google Fonts** – modern, playful branding

---

## 📦 Getting Started

1. Clone the repo
2. Make sure `.ttf` font files are added to your target and `Info.plist`
3. Run on iOS 17+ using Xcode 15 or later
4. To retrain the ML model, use CreateML or integrate user feedback for on-device fine-tuning

---

## 💬 Future Enhancements

* 🔄 iCloud sync for cross-device tracking
* 📈 Monthly history tracking
* 🔔 Smart budgeting tips via notifications
* 💡 Improve ML model with user feedback

---

> Designed with love, powered by bacon. 🐷🥓

Let me know if you'd like this in Markdown file format or if you want the README to include training data or ML pipeline steps.
