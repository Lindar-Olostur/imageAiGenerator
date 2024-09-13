//
//  TipTest.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 07.09.2024.
//

import SwiftUI
import TipKit

struct TipTest: View {
    var tip = InlineTip2()
    init() {
        try? Tips.configure()
    }
    var body: some View {
        ZStack {
            ScrollView {
                
                VStack(alignment: .leading) {
                    Text("Hello, World!")
                    
                    Text("Hello, World!")
                    Text("Hello, World!")
                }
            }
            
            VStack {
                TipView(tip, arrowEdge: .top)
                    .frame(width: 278)
                    .tint(.lTertiary)
                    .tipBackground(Color(.cPrimaryLight))
                    .offset(y: -290)
            }
        }
    }
}

#Preview {
    TipTest()
}


