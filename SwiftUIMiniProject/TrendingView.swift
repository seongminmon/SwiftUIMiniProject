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
    
    private let rows = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @EnvironmentObject var manager: LikeListManager
    @State private var marketList = [Market]()
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
            .navigationBar() {
                EmptyView()
            } trailing: {
                NavigationLink {
                    ProfileView()
                } label: {
                    ProfileImageView()
                }
            }
        }
        .onAppear {
            // TODO: - 차트뷰에서 돌아올 때 업데이트 안 되는 문제
            print("Trending onAppear")
            let ids = manager.likeList
            if ids.isEmpty {
                marketList = []
            } else {
                CoingeckoAPIManager.shared.fetchMarket(
                    ids: ids,
                    sparkLine: false
                ) { result in
                    marketList = result
                }
            }
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
                    ForEach(marketList, id: \.id) { item in
                        NavigationLink {
                            ChartView(id: item.id)
                        } label: {
                            favoriteCell(item)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    func favoriteCell(_ item: Market) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.gray.opacity(0.2))
                .frame(width: 250, height: 200)
            
            VStack {
                HStack {
                    CircleImageView(url: item.image)
                    VStack {
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(item.symbol)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Spacer()
                VStack {
                    Text(item.priceFormatted)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if item.priceChangePercentage24H >= 0 {
                        Text("+\(item.priceChangeFormatted)")
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Text("\(item.priceChangeFormatted)")
                            .foregroundStyle(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
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
                        NavigationLink {
                            ChartView(id: item.id)
                        } label: {
                            coinCell(index, item)
                        }
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
                CircleImageView(url: item.small)
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
                CircleImageView(url: item.thumb)
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
