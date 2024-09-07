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
            .tabItem {
              Image(systemName: "chart.xyaxis.line")
            }
            SearchView()
            .tabItem {
              Image(systemName: "magnifyingglass")
            }
            FavoriteView()
            .tabItem {
              Image(systemName: "creditcard")
            }
            ProfileView()
            .tabItem {
              Image(systemName: "person")
            }
        }
        .accentColor(.purple)
    }
}

#Preview {
    ContentView()
}
