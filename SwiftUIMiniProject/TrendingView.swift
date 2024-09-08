//
//  TrendingView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import SwiftUI

struct CoinItem: Hashable {
    let id: String
    let name: String
    let symbol: String
    let small: String?
    let price: Double?
    let priceChange: Double?
    
    var priceFormatted: String {
        if let price {
            let formatted = String(format: "%.2f", price)
            return "₩\(formatted)"
        } else {
            return "n\\a"
        }
    }
    
    var priceChangeFormatted: String {
        if let priceChange {
            let formatted = String(format: "%.2f", priceChange)
            return "\(formatted)%"
        } else {
            return "n\\a"
        }
    }
}

struct NFTItem: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let thumb: String?
    let price: String?
    let priceChange: Double?
    
    var priceChangeFormatted: String {
        if let priceChange {
            let formatted = String(format: "%.2f", priceChange)
            return "\(formatted)%"
        } else {
            return "n\\a"
        }
    }
}

struct TrendingView: View {
    
    // TODO: - 즐겨찾기 -> Realm -> ids -> Market 통신 -> data 세팅
    
    private let rows = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var coinList = [CoinItem]()
    @State private var nftList = [NFTItem]()
    
    var body: some View {
        NavigationView {
            ScrollView {
                favoriteSection()
                top15CoinSection()
                top7NFTSection()
            }
            .navigationTitle("Crypto Coin")
        }
        .task {
            CoingeckoAPIManager.shared.fetchTrending { trending in
                coinList = trending.coins.map {
                    let item = $0.item
                    return CoinItem(
                        id: item.id,
                        name: item.name,
                        symbol: item.symbol,
                        small: item.small,
                        price: item.data?.price,
                        priceChange: item.data?.priceChangePercentage24H["krw"]
                    )
                }
                
                nftList = trending.nfts.map {
                    return NFTItem(
                        name: $0.name,
                        symbol: $0.symbol,
                        thumb: $0.thumb,
                        price: $0.data.floorPrice,
                        priceChange: Double($0.data.floorPriceInUsd24HPercentageChange)
                    )
                }
                dump(nftList)
            }
        }
    }
    
    func favoriteSection() -> some View {
        VStack(alignment: .leading) {
            Text("My Favorite")
                .font(.title2)
                .bold()
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0..<5) { item in
                        favoriteCell()
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    func favoriteCell() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.gray.opacity(0.2))
                .frame(width: 250, height: 150)
            
            VStack {
                HStack {
                    Image(systemName: "star")
                        .frame(width: 50, height: 50)
                        .background(.orange)
                        .clipShape(Circle())
                    VStack {
                        Text("Bitcoin")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("BTC")
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Spacer()
                VStack {
                    Text("$13,235,425")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("+0.64%")
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .bold()
            }
            .padding()
        }
    }
    
    func top15CoinSection() -> some View {
        VStack(alignment: .leading) {
            Text("Top15 Coin")
                .font(.title2)
                .bold()
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows) {
                    ForEach(Array(zip(coinList.indices, coinList)), id: \.0) { index, item in
                        coinCell(index, item)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    func coinCell(_ index: Int, _ item: CoinItem) -> some View {
        VStack {
            HStack {
                Text("\(index + 1)")
                    .font(.title2)
                    .bold()
                AsyncImage(url: URL(string: item.small ?? "")) { data in
                    switch data {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                    case .failure(_):
                        Image(systemName: "star")
                    @unknown default:
                        Image(systemName: "star")
                    }
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .bold()
                    Text(item.symbol)
                }
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(item.priceFormatted)
                        .bold()
                    if let change = item.priceChange, change >= 0 {
                        Text("+\(item.priceChangeFormatted)")
                            .foregroundStyle(.red)
                    } else {
                        Text("\(item.priceChangeFormatted)")
                            .foregroundStyle(.blue)
                    }
                }
            }
            
            Text("")
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.2))
        }
        .frame(width: 300, height: 80)
        .padding(.horizontal)
    }
    
    func top7NFTSection() -> some View {
        VStack(alignment: .leading) {
            Text("Top7 NFT")
                .font(.title2)
                .bold()
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows) {
                    ForEach(Array(zip(nftList.indices, nftList)), id: \.0) { index, item in
                        nftCell(index, item)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    func nftCell(_ index: Int, _ item: NFTItem) -> some View {
        VStack {
            HStack {
                Text("\(index + 1)")
                    .font(.title2)
                    .bold()
                AsyncImage(url: URL(string: item.thumb ?? "")) { data in
                    switch data {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                    case .failure(_):
                        Image(systemName: "star")
                    @unknown default:
                        Image(systemName: "star")
                    }
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(item.name)
                        .bold()
                    Text(item.symbol)
                }
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(item.price ?? "n/a")
                        .bold()
                    if let change = item.priceChange, change >= 0 {
                        Text("+\(item.priceChangeFormatted)")
                            .foregroundStyle(.red)
                    } else {
                        Text("\(item.priceChangeFormatted)")
                            .foregroundStyle(.blue)
                    }
                }
            }
            
            Text("")
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.2))
        }
        .frame(width: 300, height: 80)
        .padding(.horizontal)
    }
}

//#Preview {
//    TrendingView()
//}
