//
//  PageControlView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 06.09.2024.
//

import SwiftUI

struct PageControlView: View {
    let numberOfPages: Int
    var currentPage: Int
    let activeColor: Color
    let inactiveColor: Color
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? activeColor : inactiveColor)
                    .frame(width: 8, height: 8)
            }
        }
    }
}

#Preview {
    PageControlView(numberOfPages: 4, currentPage: 2, activeColor: .blue, inactiveColor: .blue.opacity(0.5))
}
