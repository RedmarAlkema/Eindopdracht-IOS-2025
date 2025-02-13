import SwiftUI

struct ExpenseView: View {
    @ObservedObject var viewModel = ExpenseViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Weergave in:", selection: $viewModel.baseCurrency) {
                    Text("EUR").tag("EUR")
                    Text("USD").tag("USD")
                    Text("GBP").tag("GBP")
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: viewModel.baseCurrency) { _ in
                    viewModel.fetchExchangeRates()
                }

                List(viewModel.expenses) { expense in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(expense.description).font(.headline)
                            Text("\(expense.amount, specifier: "%.2f") \(expense.currency)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(String(format: "%.2f", (expense.amount / (viewModel.exchangeRates[expense.currency] ?? 1.0))) + " \(viewModel.baseCurrency)")
                    }
                }
                .navigationTitle("Mijn Uitgaven")
                
                Text("Totaal in \(viewModel.baseCurrency): \(viewModel.totalInBaseCurrency(), specifier: "%.2f")")
                    .font(.headline)
                    .padding()
            }
        }
    }
}
