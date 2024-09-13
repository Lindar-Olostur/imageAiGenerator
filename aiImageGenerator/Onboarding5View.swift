//
//  Onboarding5View.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI
import UserNotifications

struct Onboarding5View: View {
    @EnvironmentObject var userSettings: UserSettings
    @State private var goToNextOnboarding = false
    @State private var showAlert = false
    @State private var permissionGranted = false
    
    var body: some View {
        ZStack {
            OnboardingTemplate()
            VStack {
                ZStack {
                    Image("OB5")
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
                    Image("push5")
                        .resizable()
                        .scaledToFit()
                        .padding(18)
                        .offset(y: -40)
                }
                Spacer()
            }
            //.padding(.top, 30)
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Button {
                        if userSettings.isOnboardingCompleted {
                            print("Все выходим")
                            userSettings.finishOB()
                        } else {
                            print("CHECK SUBS")
                            checkSubscribe()
                        }
                    } label: {
                        ZStack {
                            BlurView(style: .dark)
                            Image(systemName: "xmark")
                                .tint(.lSecondary)
                        }
                        .frame(width: 36, height: 36)
                        .cornerRadius(6, corners: .allCorners)
                    }
                    .padding()
                }
                Spacer()
                Text("Stay Connected!")
                    .headerStyle(alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 4)
                    .padding(.horizontal, 20)
                
                Text("Enable notifications to be the first to know about new features and get inspiration for new creations")
                    .subHeaderStyle(alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                Button(action: {
                    requestNotificationPermission()
                }, label: {
                    Text("Turn on notifications")
                        .font(.system(size: 17))
                })
                .buttonStyle(BigButton(width: .infinity, height: 38))
                .padding()
                PageControlView(numberOfPages: 4, currentPage: 2, activeColor: .white, inactiveColor: .white.opacity(0.3)).opacity(0.0)
            }
        }
        .onAppear {
            checkNotificationPermissionStatus()
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $goToNextOnboarding) {
            PayWallView()
        }
    }
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                permissionGranted = granted
                checkSubscribe()
            }
            
            if granted {
              //  print("Notification permission granted.")
            } else {
              //  print("Notification permission denied.")
            }
        }
    }
    func checkSubscribe() {
        if SubscriptionService.shared.hasSubs {
            userSettings.finishOB()
        } else {
            goToNextOnboarding.toggle()
        }
    }
    
    func checkNotificationPermissionStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                permissionGranted = settings.authorizationStatus == .authorized
               // print("PERMIS Status: \(permissionGranted)")
            }
        }
    }
}

#Preview {
    Onboarding5View()
}
