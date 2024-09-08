//
//  String+.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/8/24.
//

import Foundation

extension String {
    func formattedISODate() -> String {
        Formatter.isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = Formatter.isoDateFormatter.date(from: self) else {
            return "날짜 형식 변환 실패"
        }
        Formatter.dateFormatter.dateFormat = "M/d HH:mm:ss"
        Formatter.dateFormatter.locale = Locale(identifier: "ko_KR")
        return Formatter.dateFormatter.string(from: date)
    }
}
