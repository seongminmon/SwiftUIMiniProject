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
                favoriteSection()
                
                top15CoinSection()
                top7NFTSection()
            }
            .navigationTitle("Crypto Coin")
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
                .padding(.horizontal)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0..<5) { i in
                        VStack {
                            ForEach(0..<3) { j in
                                coinCell()
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    func coinCell() -> some View {
        VStack {
            HStack {
                Text("\(1)")
                    .font(.title2)
                    .bold()
                Image(systemName: "star")
                    .frame(width: 50, height: 50)
                    .background(.orange)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("Solana")
                        .bold()
                    Text("LTC")
                }
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("$0.4135")
                        .bold()
                    Text("+21.18%")
                        .foregroundStyle(.red)
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
                .padding(.horizontal)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0..<5) { i in
                        VStack {
                            ForEach(0..<3) { j in
                                nftCell()
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    func nftCell() -> some View {
        VStack {
            HStack {
                Text("\(1)")
                    .font(.title2)
                    .bold()
                Image(systemName: "star")
                    .frame(width: 50, height: 50)
                    .background(.orange)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("Solana")
                        .bold()
                    Text("LTC")
                }
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("$0.4135")
                        .bold()
                    Text("+21.18%")
                        .foregroundStyle(.red)
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

#Preview {
    TrendingView()
}
