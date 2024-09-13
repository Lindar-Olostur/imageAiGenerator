//
//  Onboarding4View.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI
import StoreKit

struct Onboarding4View: View {
    @State private var goToNextOnboarding = false
    //@State private var showRate = false
    var body: some View {
        NavigationStack {
            ZStack {
                OnboardingTemplate(showblur: false)
                VStack {
                    Image("OB4")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
                VStack(alignment: .center) {
                    Spacer()
                    Text("Share Your Feedback!")
                        .headerStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)
                        .padding(.horizontal, 20)
                    
                    Text("Your feedback helps us improve. Please take a moment to rate our app!")
                        .subHeaderStyle(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    NavigationLink(destination: Onboarding5View()) {
                        Text("Continue")
                            .font(.system(size: 17))
                    }
                    .buttonStyle(BigButton(width: .infinity, height: 38))
                    .padding()
                    PageControlView(numberOfPages: 4, currentPage: 3, activeColor: .white, inactiveColor: .white.opacity(0.3))
                }
                .onAppear {
                    requestReview()
                }
            }
            .navigationDestination(isPresented: $goToNextOnboarding) {
                Onboarding5View()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
            //showRate = true
        }
    }
}

#Preview {
    Onboarding4View()
}
