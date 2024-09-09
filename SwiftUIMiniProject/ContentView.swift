//
//  ContentView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var manager = LikeListManager()
    
    var body: some View {
        TabView {
            TrendingView()
                .foregroundStyle(.black)
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                }
                .environmentObject(manager)
            
            SearchView()
                .foregroundStyle(.black)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .environmentObject(manager)
            
            FavoriteView()
                .foregroundStyle(.black)
                .tabItem {
                    Image(systemName: "creditcard")
                }
                .environmentObject(manager)
            
            ProfileView()
                .foregroundStyle(.black)
                .tabItem {
                    Image(systemName: "person")
                }
                .environmentObject(manager)
        }
        .accentColor(.purple)
        .onAppear {
            print(manager.likeList)
        }
    }
}

//#Preview {
//    ContentView()
//}
