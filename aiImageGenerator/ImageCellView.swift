//
//  ImageCellView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI

struct ImageCellView: View {
    @EnvironmentObject var userSettings: UserSettings
    var picture: Picture?
   // let url: URL?

    var body: some View {
        ZStack {
            if let url = picture?.url {
                AsyncImage(url: url) { image in
                    ZStack(alignment: .top) {
                        image
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(10, corners: .allCorners)
                            .navigationBarTitleDisplayMode(.inline)
                            HStack {
                                if picture!.isUpscaled {
                                    Image(systemName: "arrow.up.backward.and.arrow.down.forward")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .padding(2)
                                }
                                Spacer()
                                if userSettings.checkCollection(url: url) {
                                    ZStack {
                                        BlurView(style: .systemUltraThinMaterial)
                                        Image(systemName: userSettings.checkCollection(url: url) ? "heart.fill" : "heart")
                                            .font(.system(size: 20))
                                            .foregroundColor(userSettings.checkCollection(url: url) ? .cRed : .lQuoternary)
                                    }
                                    .frame(width: 36, height: 36)
                                    .cornerRadius(6, corners: .allCorners)
                                }
                            }
                            .padding(8)
                    }
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.2)
                        ProgressView()
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0.2), lineWidth: 1)
//                            .shadow(color: Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0.2), radius: 2, x: -1, y: -1)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    )
                    
                }
            } else {
                ZStack {
                    Color.gray.opacity(0.2)
                    ProgressView()
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10)) // Скругляем содержимое
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 19/255, green: 21/255, blue: 28/255, opacity: 0.2), lineWidth: 1) // Граница
                )
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2) // Тень

            }
        }
    }
}


#Preview {
    ImageCellView(picture: Picture(url: URL(string: "https://via.placeholder.com/300")!, prompt: "", negativePrompt: "Negative Negative", size: "480 x 480", isUpscaled: false, model: "Art", ratio: "1:1 - landscape"))
        .environmentObject(UserSettings())
}
