//
//  PreloaderView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI
import AppTrackingTransparency

struct PreloaderView: View {
    @EnvironmentObject var userSettings: UserSettings
    @State private var rotation: Double = 0.0
    @State private var goToNextOnboarding = false
    private var attObserver = ATTObserver()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgPrimary.ignoresSafeArea()
                Rectangle()
//                Image("startLogo")
//                    .resizable()
                    .frame(width: 150, height: 150)
                VStack {
                    Spacer()
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.7)
                        .padding(.bottom, 60)
                }
            }
            .navigationDestination(isPresented: $goToNextOnboarding) {
                Onboarding1View()
            }
        }
        .onAppear {
//            withAnimation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false)) {
//                self.rotation = 360
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                checkOnboarding()
            }
        }
    }
    func checkOnboarding() {
        requestTrackingAuthorization()
        if userSettings.isOnboardingCompleted == false {
            goToNextOnboarding = true
           // userSettings.isOnboardingCompleted = true
        } else {
            userSettings.isPreloaderVisible = false
        }
    }
    private func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { (status) in
                switch status {
                case .denied:
                    print("AuthorizationStatus is denied")
                    goToNextOnboarding = true
                case .notDetermined:
                    print("AuthorizationStatus is notDetermined")
                    goToNextOnboarding = true
                case .restricted:
                    print("AuthorizationStatus is restricted")
                    goToNextOnboarding = true
                case .authorized:
                    print("AuthorizationStatus is authorized")
                    goToNextOnboarding = true
                @unknown default:
                    fatalError("Invalid authorization status")
                }
            }
        }
        if #available(iOS 17, *) {
            attObserver.requestTrackingAuthorization {
                goToNextOnboarding.toggle()
            }
        }
    }
}

#Preview {
    PreloaderView()
        .environmentObject(UserSettings())
}
