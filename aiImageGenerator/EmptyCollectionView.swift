//
//  EmptyCollectionView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 10.09.2024.
//

import SwiftUI

struct EmptyCollectionView: View {
    @EnvironmentObject var userSettings: UserSettings
    var body: some View {
        VStack {
            Image(systemName: "photo.stack")
                .font(.system(size: 28))
                .foregroundColor(.lQuoternary)
                .padding(.bottom, 2)
                .padding(.top, 60)
            Text("Your collection is empty")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 4)
            Text("Create your first image and tap the heart on the one you like")
                .font(.system(size: 13))
                .fontWeight(.bold)
                .foregroundColor(.lSecondary)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            Button(action: {
                userSettings.selectedTab = .create
            }) {
                HStack {
                    Image(systemName: "plus")
                    Text("Create")
                        .font(.system(size: 17))
                }
            }
            .buttonStyle(BigButton(width: 108, height: 38))
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 242/255, green: 244/255, blue: 251/255, opacity: 0.06),
                    Color(red: 242/255, green: 244/255, blue: 251/255, opacity: 0.02),
                    Color(red: 242/255, green: 244/255, blue: 251/255, opacity: 0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle(lineWidth: 0.8, dash: [10]))
                .foregroundColor(.gray).opacity(0.25)
        )
        .padding()
    }
}

#Preview {
    EmptyCollectionView()
        .environmentObject(UserSettings())
}
