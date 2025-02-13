import Foundation

class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var exchangeRates: [String: Double] = [:]
    @Published var baseCurrency: String = "EUR"

    init() {
        fetchExchangeRates()
    }

    func addExpense(amount: Double, currency: String, description: String) {
        let newExpense = Expense(amount: amount, currency: currency, description: description, date: Date())
        expenses.append(newExpense)
    }

    func totalInBaseCurrency() -> Double {
        return expenses.reduce(0) { total, expense in
            let rate = exchangeRates[expense.currency] ?? 1.0
            return total + (expense.amount / rate)
        }
    }

    func fetchExchangeRates() {
        ExpenseAPI.shared.fetchExchangeRates(baseCurrency: baseCurrency) { rates in
            if let rates = rates {
                self.exchangeRates = rates
            }
        }
    }
}
