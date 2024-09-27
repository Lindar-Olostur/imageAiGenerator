import SwiftUI
import ApphudSDK

@main
struct aiImageGeneratorApp: App {
    @StateObject var viewModel = ViewModel()
    @StateObject var imageLoader = ImageLoader()
    @StateObject var aiGeneratorService = AiService()
    
    @MainActor
    init() {
        Apphud.start(apiKey: "app_9fhEm3CyQtu1i1YQGethzpdzNcpxB3")
    }
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if viewModel.isStartScreenVisible {
                    StartView()
                } else {
                    TabBarView()
                }
            }
            .environmentObject(aiGeneratorService)
            .environmentObject(viewModel)
            .environmentObject(imageLoader)
            .preferredColorScheme(.dark)
        }
    }
}
