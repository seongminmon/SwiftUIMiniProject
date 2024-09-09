//
//  FavoriteView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import SwiftUI

struct FavoriteView: View {
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var marketList = [Market]()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(marketList, id: \.id) { item in
                        NavigationLink {
                            ChartView(id: item.id)
                        } label: {
                            favoriteCell(item)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Favorite Coin")
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
        .task {
            let ids = RealmRepository.shared.fetchAll().map { $0.id }
            if ids.isEmpty { return }
            CoingeckoAPIManager.shared.fetchMarket(
                ids: ids,
                sparkLine: false
            ) { result in
                marketList = result
            }
        }
    }
    
    func favoriteCell(_ item: Market) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 25.0)
            
            VStack {
                HStack {
                    CircleImageView(url: item.image)
                    VStack {
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(item.symbol)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Spacer(minLength: 40)
                VStack {
                    Text(item.priceFormatted)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text(item.priceChangeFormatted)
                        .foregroundStyle(.red)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(.red.opacity(0.2))
                        )
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .bold()
            .padding()
        }
    }
}

//#Preview {
//    FavoriteView()
//}
