//
//  TestTabBar.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI

struct TestTabBar: View {
    @StateObject private var viewModel = ImageViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(viewModel.imageURLs, id: \.self) { url in
                        AsyncImage(url: URL(string: url)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .clipped()
                        .onAppear {
                            // Когда элемент появится на экране, проверим, не дошли ли до конца списка
                            if url == viewModel.imageURLs.last {
                                viewModel.fetchImages()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Random Images")
            .onAppear {
                viewModel.fetchImages()
            }
        }
    }
}

#Preview {
    TestTabBar()
        .environmentObject(UserSettings())
}

class ImageViewModel: ObservableObject {
    @Published var imageURLs: [String] = []
    private var isLoading = false

    func fetchImages() {
        guard !isLoading else { return }
        isLoading = true
        
        // Генерируем 20 случайных картинок
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { // добавим небольшую задержку
            let newImages = (1...20).map { _ -> String in
                let randomSize = Int.random(in: 200...300)
                return "https://loremflickr.com/\(randomSize)/\(randomSize)"
            }
            
            DispatchQueue.main.async {
                self.imageURLs.append(contentsOf: newImages)
                self.isLoading = false
            }
        }
    }
}

