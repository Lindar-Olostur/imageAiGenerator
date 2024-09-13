//
//  SegmentedControlView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI

struct SegmentedControlView: View {
    @Binding var selectedIndex: Int
    
    private let options = ["Inspirations", "Resents"]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<options.count, id: \.self) { index in
                Button(action: {
                    withAnimation {
                        selectedIndex = index
                    }
                }) {
                    VStack {
                        Text(options[index])
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(selectedIndex == index ? .white : .gray)
                            .padding(.vertical, 8)
                        
                        if selectedIndex == index {
                            Color.orange
                                .frame(height: 2)
                                .transition(.move(edge: .bottom))
                        } else {
                            Color.clear
                                .frame(height: 2)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .background(Color.clear)
    }
}


#Preview {
    SegmentedControlView(selectedIndex: .constant(0))
}
