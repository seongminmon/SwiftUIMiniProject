//
//  SearchView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import SwiftUI

struct SearchItem: Hashable {
    var id: String
    var name: String
    var symbol: String
    var thumb: String?
    var like = false
}

struct SearchView: View {
    
    @State private var searchList = [SearchItem]()
    @State private var text = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach($searchList, id: \.id) { item in
                        searchCell(item)
                    }
                }
                .padding()
            }
            .navigationTitle("Search")
            .searchable(
                text: $text,
                placement: .navigationBarDrawer,
                prompt: "코인을 검색해보세요."
            )
            .onSubmit(of: .search) {
                CoingeckoAPIManager.shared.fetchSearch(query: text) { result in
                    searchList = result.coins.map { item in
                        return SearchItem(
                            id: item.id,
                            name: item.name,
                            symbol: item.symbol,
                            thumb: item.thumb,
                            like: RealmRepository.shared.fetchItem(item.id) != nil
                        )
                    }
                }
            }
        }
    }
    
    func searchCell(_ item: Binding<SearchItem>) -> some View {
        HStack {
            CircleImageView(url: item.thumb.wrappedValue)
            VStack(alignment: .leading) {
                Text(item.name.wrappedValue)
                    .bold()
                Text(item.symbol.wrappedValue)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Button {
                if item.like.wrappedValue {
                    RealmRepository.shared.deleteItem(item.id.wrappedValue)
                } else {
                    let likedCoin = LikedCoin(id: item.id.wrappedValue)
                    RealmRepository.shared.addItem(likedCoin)
                }
                item.like.wrappedValue.toggle()
            } label: {
                Image(systemName: item.like.wrappedValue ? "star.fill" : "star")
            }
            .foregroundStyle(.purple)
        }
    }
}

//#Preview {
//    SearchView()
//}
