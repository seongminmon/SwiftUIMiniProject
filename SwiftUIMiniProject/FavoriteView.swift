//
//  FavoriteView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import SwiftUI

struct FavoriteView: View {
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0..<5) { item in
                        favoriteCell()
                    }
                }
                .padding()
            }
            .navigationTitle("Favorite Coin")
        }
    }
    
    func favoriteCell() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 25.0)
            
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
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Spacer(minLength: 40)
                VStack {
                    Text("$13,235,425")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("+0.64%")
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

#Preview {
    FavoriteView()
}
