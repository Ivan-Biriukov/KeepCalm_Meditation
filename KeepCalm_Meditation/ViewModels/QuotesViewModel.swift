import Foundation

class QuotesViewModel {
    
    static let shared = QuotesViewModel()
    
    let quoteURLString = "https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en"
    
    var currentQoute = Dynamic(QuoteModel(quoteText: "", quoteAuthor: ""))
    
    func fetchQoute() {
        if let url = URL(string: quoteURLString) {
            let session = URLSession(configuration: .default)
            let task =  session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                if let safeData = data {
                    let quoteURLString = String(data: safeData, encoding: .utf8)
                    self.parseJson(quoteData:safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJson(quoteData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(QuoteModel.self, from: quoteData)
            self.currentQoute.value = decodedData
        }
        catch {
            print(error)
        }
    }
    
}
