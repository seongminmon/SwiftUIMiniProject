//
//  ContentView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            TrendingView()
                .foregroundStyle(.black)
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                }
            
            SearchView()
                .foregroundStyle(.black)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
            FavoriteView()
                .foregroundStyle(.black)
                .tabItem {
                    Image(systemName: "creditcard")
                }
            
            ProfileView()
                .foregroundStyle(.black)
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .accentColor(.purple)
    }
}

//#Preview {
//    ContentView()
//}
