//
//  ChartView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    // 코인 검색 뷰 셀 탭
    // 즐겨찾기 셀 탭
    // 트렌딩 즐겨찾기 셀 탭
    // 트렌딩 top15coin 셀 탭
    
    let id: String
    @State private var market = Market(id: "", name: "", symbol: "", image: "", currentPrice: 0, priceChangePercentage24H: 0, low24H: 0, high24H: 0, ath: 0, athDate: "", atl: 0, atlDate: "", lastUpdated: "", sparklineIn7d: nil)
    
    private var areaBackground: Gradient {
        return Gradient(colors: [Color.purple.opacity(0.8), Color.purple.opacity(0.1)])
    }
    
    var body: some View {
        ScrollView() {
            VStack {
                infoView()
                Spacer(minLength: 60)
//                chart()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .task {
            CoingeckoAPIManager.shared.fetchMarket(
                ids: [id],
                sparkLine: true
            ) { result in
                if let item = result.first {
                    market = item
                }
            }
        }
    }
    
    func infoView() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "star")
                    Text("Solana")
                        .font(.title)
                        .bold()
                }
                Text("₩15,456,345")
                    .font(.title)
                    .bold()
                HStack {
                    Text("+3.22%")
                        .foregroundStyle(.red)
                    Text("Today")
                        .foregroundStyle(.gray)
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("고가")
                        .bold()
                        .foregroundStyle(.red)
                    Text("₩24915234")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("저가")
                        .bold()
                        .foregroundStyle(.blue)
                    Text("₩24915234")
                }
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("신고점")
                        .bold()
                        .foregroundStyle(.red)
                    Text("₩24915234")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("신저점")
                        .bold()
                        .foregroundStyle(.blue)
                    Text("₩24915234")
                }
            }
        }
    }
    
//    func chart() -> some View {
//        Chart {
//            ForEach(Array(zip(salesData.indices, salesData)), id: \.0) { index, item in
//                LineMark(
//                    x: .value("Date", index),
//                    y: .value("Price", item)
//                )
//                .foregroundStyle(.purple)
//                .lineStyle(StrokeStyle(lineWidth: 2))
//                .interpolationMethod(.catmullRom)
//                
//                AreaMark(
//                    x: .value("Date", index),
//                    y: .value("Price", item)
//                )
//                .interpolationMethod(.catmullRom)
//                .foregroundStyle(areaBackground)
//            }
//        }
//        .frame(height: 300)
//    }
}

//#Preview {
//    ChartView()
//}
