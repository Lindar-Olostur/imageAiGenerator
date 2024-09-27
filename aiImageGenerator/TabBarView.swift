import SwiftUI
import UIKit

struct TabBarView: View {
    @EnvironmentObject var aiService: AiService
    @EnvironmentObject var imageLoader: ImageLoader
    @EnvironmentObject var viewModel: ViewModel
    @State private var selectedTab = Tab.create
    @State private var goToGengallery = false
    @State private var showProgressView = false
    
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
            .fullScreenCover(isPresented: $showProgressView, content: {
                ProgressGenerationView()
                    .background(BackgroundClearView())
            })
        }
        .onDisappear {
            viewModel.saveToUD()
        }
        .onReceive(viewModel.$testGeneration, perform: { value in
            goToGengallery = value
        })
        .onReceive(viewModel.$testProgress, perform: { value in
            withAnimation {
                showProgressView = value
            }
        })
        .onReceive(viewModel.$selectedTab) { value in
            selectedTab = value
        }
        .onChange(of: selectedTab) {
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(AiService())
        .environmentObject(ImageLoader())
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}

enum Tab {
    case create
    case inspiration
    case collection
}
