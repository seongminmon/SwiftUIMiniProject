//
//  ChartView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    // MARK: - 차트뷰로 진입하는 경우
    // 트렌딩 즐겨찾기 셀 탭
    // 트렌딩 top15coin 셀 탭
    // 코인 검색 뷰 셀 탭
    // 즐겨찾기 셀 탭
    
    // TODO: - 즐겨찾기 버튼 만들기 + 기능 구현
    
    let id: String
    @State private var market = Market(id: "", name: "", symbol: "", image: "", currentPrice: 0, priceChangePercentage24H: 0, low24H: 0, high24H: 0, ath: 0, athDate: "", atl: 0, atlDate: "", lastUpdated: "", sparklineIn7d: nil)
    
    private var areaBackground: Gradient {
        return Gradient(colors: [Color.purple.opacity(0.8), Color.purple.opacity(0.1)])
    }
    
    var body: some View {
        ScrollView() {
            VStack {
                infoView(market)
                Spacer(minLength: 60)
                chart(market.sparklineIn7d?.price ?? [])
                Text("\(market.lastUpdated.formattedISODate()) 업데이트")
                    .bold()
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
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
                    print(market.lastUpdated)
                }
            }
        }
    }
    
    func infoView(_ item: Market) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    CircleImageView(url: item.image)
                    Text(item.name)
                        .font(.title)
                        .bold()
                }
                Text(item.priceFormatted)
                    .font(.title)
                    .bold()
                HStack {
                    if item.priceChangePercentage24H >= 0 {
                        Text("+\(item.priceChangeFormatted)")
                            .foregroundStyle(.red)
                    } else {
                        Text("\(item.priceChangeFormatted)")
                            .foregroundStyle(.blue)
                    }
                    Text("Today")
                        .foregroundStyle(.gray)
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("고가")
                        .bold()
                        .foregroundStyle(.red)
                    Text(item.high24HFormatted)
                        .padding(.bottom)
                    
                    Text("신고점")
                        .bold()
                        .foregroundStyle(.red)
                    Text(item.athFormatted)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("저가")
                        .bold()
                        .foregroundStyle(.blue)
                    Text(item.low24HFormatted)
                        .padding(.bottom)
                    
                    Text("신저점")
                        .bold()
                        .foregroundStyle(.blue)
                    Text(item.atlFormatted)
                }
            }
        }
    }
    
    func chart(_ data: [Double]) -> some View {
        Chart {
            ForEach(Array(zip(data.indices, data)), id: \.0) { index, item in
                LineMark(
                    x: .value("Date", index),
                    y: .value("Price", item)
                )
                .foregroundStyle(.purple)
                .lineStyle(StrokeStyle(lineWidth: 2))
                .interpolationMethod(.catmullRom)
                
                AreaMark(
                    x: .value("Date", index),
                    y: .value("Price", item)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(areaBackground)
            }
        }
        .frame(height: 300)
    }
}

//#Preview {
//    ChartView(id: "bitcoin")
//}
