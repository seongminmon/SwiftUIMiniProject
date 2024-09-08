//
//  CoingeckoAPIManager.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/8/24.
//

import Foundation

final class CoingeckoAPIManager {
    static let shared = CoingeckoAPIManager()
    private init() {}
    
    func fetchTrending(handler: @escaping (Trending) -> Void) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/search/trending") else {
            print("url 없음")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                print("data 없음")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Trending.self, from: data)
                handler(result)
            } catch {
                print("디코딩 실패")
            }
        }.resume()
    }
    
    func fetchSearch(query: String, handler: @escaping (Search) -> Void) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/search?query=\(query)") else {
            print("url 없음")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                print("data 없음")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Search.self, from: data)
                handler(result)
            } catch {
                print("디코딩 실패")
            }
        }.resume()
    }
    
    func fetchMarket(ids: [String], sparkLine: Bool, handler: @escaping ([Market]) -> Void) {
        var urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=krw"
        urlString += "&ids=\(ids.joined(separator: ","))"
        if sparkLine {
            urlString += "&sparkline=true"
        }
        guard let url = URL(string: urlString) else {
            print("url 없음")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                print("data 없음")
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Market].self, from: data)
                handler(result)
            } catch {
                print("디코딩 실패")
            }
        }.resume()
    }
}
