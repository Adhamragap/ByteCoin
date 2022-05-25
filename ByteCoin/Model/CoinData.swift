//
//  CoinData.swift
//  ByteCoin
//
//  Created by adham ragap on 05/05/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation
struct CoinData:Codable {
    let rate: Double
    var rateRonded : String {
        return String (format: "%.2F", rate)
    }
    
}
