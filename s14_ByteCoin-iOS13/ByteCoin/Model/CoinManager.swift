//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, coinModel: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {

    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"

    let currencyArray = ["AUD", "BRL", "CAD", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]

    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)/?apikey=\(apiKey)"
        print(urlString)
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        //1. create URL
        if let url = URL(string: urlString) {
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coinModel = parseJSON(safeData) {
                        delegate?.didUpdatePrice(self, coinModel: coinModel)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }

    func parseJSON(_ priceData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(CoinData.self, from: priceData)
            let coinModal = CoinModel(
                    rate: String(format: "%.2f", decodeData.rate),
                    baseCurrency: decodeData.asset_id_base,
                    quoteCurrency: decodeData.asset_id_quote
            )
            return coinModal
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
