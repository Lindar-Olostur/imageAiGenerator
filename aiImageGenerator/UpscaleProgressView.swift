//
//  UpscaleProgressView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 11.09.2024.
//

import SwiftUI

struct UpscaleProgressView: View {
    @EnvironmentObject var userSettings: UserSettings
    @Binding var isOpen: Bool
    @State private var timer: Timer?
    @State private var progress = 0.0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            BlurView(style: .dark)
                .contentShape(Rectangle())
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                isOpen.toggle()
                                progress = 0.0
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
                        VStack(spacing: 10) {
                            ProgressCircle(progress: $progress)
                            
                            Text("Image upscaling ")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top, 8)
                            Text("Hold it open and wait for the image to be created. It may take up to a minute to generate.")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.lSecondary)
                                .padding(.horizontal, 28)
                                .multilineTextAlignment(.center)
                        }
//                                Button("GET") {
//                                    withAnimation {
//                                        openGallery.toggle()
//                                    }
//
//                                    //userSettings.testGeneration = true
//                                    //userSettings.testProgress = false
//                                    //self.presentationMode.wrappedValue.dismiss()
//                                }
                        Spacer()
                        VStack {
                            Text("You want to go faster?")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.white)
                            //.padding(.top, 8)
                            Button {
                                userSettings.testProgress = false
                                userSettings.openPaywall.toggle()
                                progress = 0.0
                            } label: {
                                HStack {
                                    Image(systemName: "crown.fill")
                                        .font(.system(size: 15))
                                    Text("Upgrade to Pro")
                                        .font(.system(size: 18))
                                        .bold()
                                }
                            }
                            .buttonStyle(BigButton(width: 166, height: 20))
                            .scaleEffect(0.8)
                        }
                        .padding(.bottom)
                        .opacity(SubscriptionService.shared.hasSubs ? 0 : 1)
                        
                    }
                )
        }
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                if progress < 1.0 {
                    progress += Double.random(in: 0.001...0.008)
                    if progress >= 1.0 {
                        progress = 1.0
                        timer?.invalidate()
                        timer = nil
                        isOpen.toggle()
                    }
                }
            }
        }
    }
    
}

#Preview {
    UpscaleProgressView(isOpen: .constant(true))
        .environmentObject(UserSettings())
}
