import Foundation

class ExpenseAPI {
    static let shared = ExpenseAPI()
    
    private let baseURL = "https://v6.exchangerate-api.com/v6/"
    private let apiKey = "af912e470c2e52ef8450f712"  // API Key

    func fetchExchangeRates(baseCurrency: String, completion: @escaping ([String: Double]?) -> Void) {
        let urlString = "\(baseURL)\(apiKey)/latest/\(baseCurrency)"
        
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ API Request Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("❌ No data received")
                completion(nil)
                return
            }

            do {
                let decodedData = try JSONDecoder().decode([String: [String: Double]].self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData["rates"])
                }
            } catch {
                print("❌ JSON Decoding Error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
