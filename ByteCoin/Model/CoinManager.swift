//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate{
    func getCoinData(coin:CoinData)
    func didFailWithError(error:Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "AC168B43-DE5C-4624-BAC5-5B6A32704431"
    var delegate:CoinManagerDelegate?
//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=AC168B43-DE5C-4624-BAC5-5B6A32704431
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
         fetchData(urlString:urlString)
       
    }
    func fetchData(urlString:String){
        guard let url = URL(string: urlString)else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                delegate?.didFailWithError(error:error!)
                return
            }
            guard let dataCoin = data else {
                print("data not coming")
                return
            }
            guard let coin =  parseJson(data: dataCoin)else {return}
            delegate?.getCoinData(coin:coin)
        }
        task.resume()
    }
    func parseJson (data:Data) -> CoinData? {
        do {
           let decodeCoin = try JSONDecoder().decode(CoinData.self, from: data)
            return decodeCoin
        }catch {
            delegate?.didFailWithError(error:error)
            return nil
        }
    }
}
