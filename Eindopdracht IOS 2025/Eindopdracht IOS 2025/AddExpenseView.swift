import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    @State private var amount: String = ""
    @State private var currency: String = "USD"
    @State private var description: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Bedrag", text: $amount)
                    .keyboardType(.decimalPad)
                
                Picker("Valuta", selection: $currency) {
                    Text("THB (Baht)").tag("THB")
                    Text("MYR (Ringgit)").tag("MYR")
                    Text("JPY (Yen)").tag("JPY")
                    Text("EUR (Euro)").tag("EUR")
                    Text("USD (Dollar)").tag("USD")
                }
                
                TextField("Omschrijving", text: $description)
                
                Button("Toevoegen") {
                    if let amountValue = Double(amount) {
                        viewModel.addExpense(amount: amountValue, currency: currency, description: description)
                    }
                }
            }
            .navigationTitle("Nieuwe Uitgave")
        }
    }
}
