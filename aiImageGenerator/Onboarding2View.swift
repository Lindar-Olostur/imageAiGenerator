//
//  Onboarding2View.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI

struct Onboarding2View: View {
    var body: some View {
        NavigationStack {
            ZStack {
                OnboardingTemplate()
                VStack {
                    Image("OB2")
                        .resizable()
                        //.scaledToFit()
                        .aspectRatio(3/5, contentMode: .fit)
                        //.scaleEffect(0.85)
                        //.offset(y: 50)
                        .padding(.horizontal, 40)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.clear, location: 0),
                                    .init(color: Color(.bgPrimary), location: 0.75)
                                ]),
                                startPoint: UnitPoint(x: 0.5, y: 0.6),
                                endPoint: .bottom
                            )
                        )
                    Spacer()
                }
                //.padding(.top, 30)
                VStack(alignment: .center) {
                    Spacer()
                    Text("Explore a World of Creativity!")
                        .headerStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)
                        .padding(.horizontal, 20)
                    
                    Text("Discover thousands of images created by other users and get inspired by their ideas")
                        .subHeaderStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    NavigationLink(destination: Onboarding3View()) {
                        Text("Continue")
                            .font(.system(size: 17))
                    }
                    .buttonStyle(BigButton(width: .infinity, height: 38))
                    .padding()
                    PageControlView(numberOfPages: 4, currentPage: 1, activeColor: .white, inactiveColor: .white.opacity(0.3))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Onboarding2View()
}
