//
//  GenerationGalleryView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI

struct GenerationGalleryView: View {
    @EnvironmentObject var aiService: AiService
    @EnvironmentObject var userSettings: UserSettings
    @State private var openPaywall = false
    @Binding var openGallery: Bool
    //@State var pictures: [Picture] = []
    
    var body: some View {
        //ImageGalleryView()
        NavigationStack {
        ZStack {
            Color.bgPrimary
                .ignoresSafeArea()
                VStack {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(aiService.genImages) { imageData in
                                NavigationLink(destination: ImageDetailView(imageUrl: imageData.url, picture: imageData)) {
                                    ImageCellView(picture: imageData)
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Button(action : {
                        userSettings.testProgress = false
                        aiService.progress = 0.0
                    }){
                        Text("Close")
                    })
                    Button {
                        if let prompt = aiService.genImages.first?.prompt {
                            openGallery.toggle()
                            Task {
                                await aiService.generateImage(prompt: prompt)
                            }
                        }
                    } label: {
                        Text("\(Image(systemName: "arrow.triangle.2.circlepath")) Recreate")
                            .font(.system(size: 17))
                    }
                    .buttonStyle(BigButton(width: .infinity, height: 38))
                    .padding()
                }
                .navigationTitle("Select Result")
                .toolbar {
                    if !SubscriptionService.shared.hasSubs {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                DispatchQueue.main.async {
                                    userSettings.testProgress = false
                                    userSettings.openPaywall.toggle()
                                    aiService.progress = 0.0
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "crown.fill")
                                        .font(.system(size: 15))
                                    Text("Pro")
                                        .font(.system(size: 18))
                                        .bold()
                                }
                            }
                            .buttonStyle(BigButton(width: 72, height: 24))
                            .scaleEffect(0.8)
                        }
                    }
                }
//                .onReceive(aiService.$errorMessage) { value in
//                    userSettings.testProgress = false
//                }
                //Text("\(aiService.generatedImageData.map {$0.url})")
                //ImageGalleryView()
            }
//            .fullScreenCover(isPresented: $openPaywall) {
//                PayWallView()
//            }
        }
//        .onAppear(perform: {
//            pictures = aiService.genImages
//        })
    }
}

#Preview {
    GenerationGalleryView(openGallery: .constant(true))
        .environmentObject(AiService())
        .environmentObject(UserSettings())
}
