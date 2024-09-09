//
//  ChartView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/7/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    // TODO: - 좋아요 뷰와 연동하기
    // TODO: - Realm에 데이터 추가 / 삭제를 하더라도 @State가 아니기 때문에 뷰가 렌더링 되지 않음
    
    let id: String
    @State private var market = Market(id: "", name: "", symbol: "", image: "", currentPrice: 0, priceChangePercentage24H: 0, low24H: 0, high24H: 0, ath: 0, athDate: "", atl: 0, atlDate: "", lastUpdated: "", sparklineIn7d: nil)
    
    var like: Bool {
        return RealmRepository.shared.fetchItem(id) != nil
    }
    
    private let areaBackground = Gradient(colors: [.purple.opacity(0.8), .purple.opacity(0.1)])
    
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
        .navigationBar() {
            EmptyView()
        } trailing: {
            Button {
                if like {
                    RealmRepository.shared.deleteItem(id)
                } else {
                    RealmRepository.shared.addItem(LikedCoin(id: id))
                }
            } label: {
                Image(systemName: like ? "star.fill" : "star")
                    .foregroundStyle(.purple)
            }
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
            ForEach(Array(data.enumerated()), id: \.element) { index, item in
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
