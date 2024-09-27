import SwiftUI

struct GenerationGalleryView: View {
    @EnvironmentObject var aiService: AiService
    @EnvironmentObject var viewModel: ViewModel
    @State private var openPaywall = false
    @Binding var openGallery: Bool
    
    var body: some View {
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
                        viewModel.testProgress = false
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
                    .buttonStyle(MainButton(width: .infinity, height: 38))
                    .padding()
                }
                .navigationTitle("Select Result")
                .toolbar {
                    if !SubscriptionService.shared.hasSubs {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                DispatchQueue.main.async {
                                    viewModel.testProgress = false
                                    viewModel.openPaywall.toggle()
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
                            .buttonStyle(MainButton(width: 72, height: 24))
                            .scaleEffect(0.8)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GenerationGalleryView(openGallery: .constant(true))
        .environmentObject(AiService())
        .environmentObject(ViewModel())
}
