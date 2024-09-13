//
//  InspirationView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI

struct InspirationView: View {
    @EnvironmentObject var imageLoader: ImageLoader
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack(alignment: .top) {
                    Color.bgPrimary
                        .ignoresSafeArea()
                    ScrollView(showsIndicators: false) {
                        Text("Find AI generated images")
                            .headerStyle(alignment: .center)
                            .padding(.top, 75)
                            .padding(.bottom, 20)
                        ImageGalleryView(pictures: imageLoader.images)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("aiLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96, height: 28)
                }
                if !SubscriptionService.shared.hasSubs {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            userSettings.openPaywall.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "crown.fill")
                                    .font(.system(size: 15))
                                Text("Pro")
                                    .font(.system(size: 18))
                                    .bold()
                            }
                        }
                        .buttonStyle(BigButton(width: 72, height: 24, opacity: 0.0))
                        .scaleEffect(0.8)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                            .tint(.cPrimaryLight)
                    }
                }
            }
        }
    }
}

#Preview {
    InspirationView()
        .environmentObject(ImageLoader())
        .environmentObject(UserSettings())
}


