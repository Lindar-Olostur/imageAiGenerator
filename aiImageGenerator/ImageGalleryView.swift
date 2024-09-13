//
//  ImageGalleryView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI

struct ImageGalleryView: View {
//    @EnvironmentObject var imageLoader: ImageLoader
    @State var pictures: [Picture] = []

    var body: some View {
//        NavigationStack {
            VStack {
                VStack {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(pictures) { imageData in
                                NavigationLink(destination: ImageDetailView(imageUrl: imageData.url, picture: imageData)) {
                                    ImageCellView(picture: imageData)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .background(Color.clear)
//        }
    }
}


#Preview {
    ImageGalleryView()//.environmentObject(ImageLoader())
}
