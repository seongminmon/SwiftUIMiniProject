//
//  Trending.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import Foundation

struct Trending: Decodable {
    let coins: [Item]
    let nfts: [NFT]
}

struct Item: Decodable {
    let item: Coin
}

struct Coin: Decodable {
    let id: String
    let name: String
    let symbol: String
    let small: String?
    let data: ItemData?
    let thumb: String?
}

struct ItemData: Decodable {
    let price: Double
    let priceChangePercentage24H: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case price
        case priceChangePercentage24H = "price_change_percentage_24h"
    }
}

struct NFT: Decodable {
    let name: String
    let symbol: String
    let thumb: String
    let data: NFTData
}

struct NFTData: Decodable {
    let floorPrice: String
    let floorPriceInUsd24HPercentageChange: String

    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
        case floorPriceInUsd24HPercentageChange = "floor_price_in_usd_24h_percentage_change"
    }
}
