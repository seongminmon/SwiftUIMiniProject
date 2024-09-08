//
//  Market.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import Foundation

struct Market: Decodable {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let currentPrice: Double
    let priceChangePercentage24H: Double
    let low24H: Double
    let high24H: Double
    let ath: Double
    let athDate: String
    let atl: Double
    let atlDate: String
    let lastUpdated: String
    let sparklineIn7d: SparklineIn7D?
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, image
        case currentPrice = "current_price"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case low24H = "low_24h"
        case high24H = "high_24h"
        case ath, atl
        case athDate = "ath_date"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7d = "sparkline_in_7d"
    }
    
    var priceFormatted: String {
        return "₩\(currentPrice.formatted())"
    }

    var priceChangeFormatted: String {
        let formatted = String(format: "%.2f", priceChangePercentage24H)
        return "\(formatted)%"
    }
}

struct SparklineIn7D: Decodable {
    let price: [Double]
}
