//
//  TabView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI
import UIKit

struct TabsView: View {
    @EnvironmentObject var aiService: AiService
    @EnvironmentObject var imageLoader: ImageLoader
    @EnvironmentObject var userSettings: UserSettings
    @State private var selectedTab = Tab.create
    @State private var goToGengallery = false
    @State private var showProgressView = false
//    @State private var openPaywall = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $selectedTab) {
                    CreateView()
                        .tag(Tab.create)
                        .tabItem {
                            Label("Create", systemImage: "pencil.line")
                        }
                    InspirationView()
                        .tag(Tab.inspiration)
                        .tabItem {
                            Label("Inspiration", systemImage: "plus.magnifyingglass")
                        }
                    CollectionView()
                        .tag(Tab.collection)
                        .tabItem {
                            Label("Collection", systemImage: "sparkles.rectangle.stack")
                        }
                }
            }
            //            .toolbarBackground(.visible, for: .navigationBar)
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarLeading) {
            //                    Image("aiLogo")
            //                        .resizable()
            //                        .scaledToFit()
            //                        .frame(width: 96, height: 28)
            //                }
            //                if !SubscriptionService.shared.hasSubs {
            //                    ToolbarItem(placement: .navigationBarTrailing) {
            //                        Button {
            //                            openPaywall.toggle()
            //                        } label: {
            //                            HStack {
            //                                Image(systemName: "crown.fill")
            //                                    .font(.system(size: 15))
            //                                Text("Pro")
            //                                    .font(.system(size: 18))
            //                                    .bold()
            //                            }
            //                        }
            //                        .buttonStyle(BigButton(width: 72, height: 24))
            //                        .scaleEffect(0.8)
            //                    }
            //                }
            //                ToolbarItem(placement: .navigationBarTrailing) {
            //                    Button(action: {
            //                        print("Right button tapped")
            //                    }) {
            //                        Image(systemName: "gearshape")
            //                            .tint(.cPrimaryLight)
            //                    }
            //                }
            //            }
            .fullScreenCover(isPresented: $showProgressView, content: {
                ProgressGenerationView()
                    .background(BackgroundClearView()) // calling the function
            })
//            .fullScreenCover(isPresented: $openPaywall) {
//                PayWallView()
//            }
        }
        .onDisappear {
            userSettings.saveUserToUserDefaults()
        }
        .onReceive(userSettings.$testGeneration, perform: { value in
            goToGengallery = value
        })
        .onReceive(userSettings.$testProgress, perform: { value in
            withAnimation {
                showProgressView = value
            }
        })
        .onReceive(userSettings.$selectedTab) { value in
            selectedTab = value
        }
        .onChange(of: selectedTab) {
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
        }
//        .onReceive(userSettings.$openPaywall) { value in
//            openPaywall = value
//        }
    }
}

#Preview {
    TabsView()
        .environmentObject(AiService())
        .environmentObject(ImageLoader())
        .environmentObject(UserSettings())
        .preferredColorScheme(.dark)
}

enum Tab {
    case create
    case inspiration
    case collection
}
