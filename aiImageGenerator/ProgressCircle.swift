//
//  ProgressCircle.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 10.09.2024.
//

import SwiftUI

struct ProgressCircle: View {
    @Binding var progress: Double
    let lineWidth: CGFloat = 6
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.gray.opacity(0.1),
                    lineWidth: lineWidth
                )
                .frame(width: 184, height: 184)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.cPrimaryLight,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .frame(width: 184, height: 184)
                .rotationEffect(.degrees(-90))
            Text("\(Int(progress * 100))%")
                .font(.system(size: 34, weight: .regular, design: .monospaced))
                .foregroundColor(.white)
                .animation(.none)
        }
    }
}


#Preview {
    ProgressCircle(progress: .constant(0.30))
}
