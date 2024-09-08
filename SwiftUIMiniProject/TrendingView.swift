//
//  TrendingView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import SwiftUI

struct TrendingView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                Text("My Favorite")
                    .font(.title2)
                    .bold()
                Text("Top15 Coin")
                    .font(.title2)
                    .bold()
                Text("Top7 NFT")
                    .font(.title2)
                    .bold()
            }
            .navigationTitle("Crypto Coin")
        }
        .task {
            print("통신 시작")
            CoingeckoAPIManager.shared.fetchMarket(
                ["bitcoin", "wrapped-bitcoin"],
                sparkLine: false
            ) { result in
                dump(result)
            }
        }
    }
}
