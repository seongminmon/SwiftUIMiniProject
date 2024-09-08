//
//  Text+.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/8/24.
//

import SwiftUI

extension Text {
    init(_ text: String, highlight: String, color: Color) {
        var attributedString = AttributedString(text)
        var searchStartIndex = attributedString.startIndex
        while let range = attributedString[searchStartIndex...].range(of: highlight) {
            let startIndex = range.lowerBound
            let endIndex = range.upperBound
            attributedString[startIndex..<endIndex].foregroundColor = color
            searchStartIndex = endIndex
        }
        self.init(attributedString)
    }
}
