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
}

struct SearchView: View {
    
    // TODO: - 좋아요 뷰와 연동하기
    @State private var searchList = [SearchItem]()
    @State private var text = ""
    
    func like(_ id: String) -> Bool {
        return RealmRepository.shared.fetchItem(id) != nil
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(searchList, id: \.id) { item in
                        NavigationLink {
                            ChartView(id: item.id)
                        } label: {
                            searchCell(item)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Search")
            .navigationBar() {
                EmptyView()
            } trailing: {
                NavigationLink {
                    ProfileView()
                } label: {
                    ProfileImageView()
                }
            }
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
                            thumb: item.thumb
                        )
                    }
                }
            }
        }
    }
    
    func searchCell(_ item: SearchItem) -> some View {
        HStack {
            CircleImageView(url: item.thumb)
            VStack(alignment: .leading) {
                Text(item.name, highlight: text, color: .purple)
                    .bold()
                Text(item.symbol)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Button {
                if like(item.id) {
                    RealmRepository.shared.deleteItem(item.id)
                } else {
                    RealmRepository.shared.addItem(LikedCoin(id: item.id))
                }
            } label: {
                Image(systemName: like(item.id) ? "star.fill" : "star")
            }
            .foregroundStyle(.purple)
        }
    }
}

//#Preview {
//    SearchView()
//}
