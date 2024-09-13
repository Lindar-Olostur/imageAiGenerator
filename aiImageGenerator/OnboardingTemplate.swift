//
//  OnboardingTemplate.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI

struct OnboardingTemplate: View {
    var showblur: Bool = true
    let backgroundGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.09, green: 0.11, blue: 0.14), location: 0.00),
            Gradient.Stop(color: Color(red: 0.08, green: 0.09, blue: 0.1), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
    )
    var body: some View {
        ZStack {
            Color.bgPrimary
            if showblur {
                Image("")
                    .frame(width: 340, height: 150)
                    .background(Color.cPrimaryLight)
                    .blur(radius: 37.5)
                    .opacity(0.65)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingTemplate()
}
