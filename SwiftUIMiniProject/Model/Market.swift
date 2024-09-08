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
    let currentPrice: Int
    let priceChangePercentage24H: Double
    let low24H: Int
    let high24H: Int
    let ath: Int
    let athDate: String
    let atl: Int
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
}

struct SparklineIn7D: Decodable {
    let price: [Double]
}

/*
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 73068431,
     "market_cap": 1441805837567551,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 1532987883902658,
     "total_volume": 57107329415013,
     "high_24h": 75502740,
     "low_24h": 70526358,
     "price_change_24h": -2434309.3433693796,
     "price_change_percentage_24h": -3.22413,
     "market_cap_change_24h": -50560261122912.75,
     "market_cap_change_percentage_24h": -3.38793,
     "circulating_supply": 19750921.0,
     "total_supply": 21000000.0,
     "max_supply": 21000000.0,
     "ath": 98576718,
     "ath_change_percentage": -25.92472,
     "ath_date": "2024-06-07T13:55:20.414Z",
     "atl": 75594,
     "atl_change_percentage": 96496.51525,
     "atl_date": "2013-07-05T00:00:00.000Z",
     "roi": null,
     "last_updated": "2024-09-07T13:30:33.928Z"
 },
 */
