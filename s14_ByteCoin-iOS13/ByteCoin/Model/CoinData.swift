//
// Created by Ray WU on 23/05/2022.
// Copyright (c) 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let rate: Double
    let asset_id_base: String
    let asset_id_quote: String
}