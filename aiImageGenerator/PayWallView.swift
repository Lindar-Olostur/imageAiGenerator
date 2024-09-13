//
//  PayWallView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI

struct PayWallView: View {
    @EnvironmentObject var userSettings: UserSettings
    @Environment(\.presentationMode) var presentationMode
    @State var isYearProduct = false
    let isTrial = true
    var body: some View {
        ZStack {
            OnboardingTemplate(showblur: false)
            VStack {
                Image("paywall")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.clear, location: 0),
                                .init(color: Color(.bgPrimary), location: 0.45)
                            ]),
                            startPoint: UnitPoint(x: 0.5, y: 0.2),
                            endPoint: .bottom
                        )
                    )
                Spacer()
            }
            VStack(alignment: .center) {
                HStack {
                    Button {
                        if userSettings.isOnboardingCompleted {
                          //  print("OB - comp")
                            userSettings.openPaywall = false
                            presentationMode.wrappedValue.dismiss()
                        } else {
                         //   print("OB - NOT comp")
                            userSettings.finishOB()
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        ZStack {
                            BlurView(style: .systemThinMaterialDark)
                            Image(systemName: "xmark")
                                .tint(.lSecondary)
                        }
                        .frame(width: 36, height: 36)
                        .cornerRadius(6, corners: .allCorners)
                    }
                    .padding()
                    Spacer()
                    Button {
                        userSettings.finishOB()
                        Task {
                            await SubscriptionService.shared.restorePurchases()
                        }
                    } label: {
                        ZStack {
                            BlurView(style: .systemThinMaterialDark)
                            Text("Restore")
                                .font(.system(size: 16))
                                .tint(.lSecondary)
                        }
                        .background(.thinMaterial)
                        .frame(width: 77, height: 36)
                        .cornerRadius(6, corners: .allCorners)
                    }
                    .padding()
                }
                Spacer()
                HStack {
                    Image(.aiLogo)
                        .resizable()
                        .frame(width: 184, height: 52)
                    Button {} label: {
                        HStack {
                            Image(systemName: "crown.fill")
                                .font(.system(size: 20))
                            Text("Pro")
                                .font(.system(size: 20))
                                .bold()
                        }
                    }
                    .buttonStyle(BigButton(width: 72, height: 26))
                    .disabled(true)
                    .scaleEffect(0.8)
                }
                Text("Unlock all features with Pro")
                    .font(.system(size: 15))
                    .foregroundStyle(.lSecondary)
                VStack(alignment: .leading, spacing: 14) {
                    Text("\(Image(systemName: "checkmark.circle.fill")) Fast processing")
                    Text("\(Image(systemName: "checkmark.circle.fill")) Unlimited artwork creation")
                    Text("\(Image(systemName: "checkmark.circle.fill")) Increase image size by 2x")
                    Text("\(Image(systemName: "checkmark.circle.fill")) Unlimited background removal")
                }
                .foregroundStyle(.white)
                .font(.system(size: 16))
                .padding(30)
                CheckboxButton(isChecked: $isYearProduct, isActive: false, isTrial: isTrial, period: .monthly, priseFull: "$19.99", priseWeek: "$4.99")
                    .padding(.bottom, 4)
                CheckboxButton(isChecked: $isYearProduct, isActive: true, isTrial: isTrial, period: .yearly, priseFull: "$39.99", priseWeek: "$1.87")
                    .padding(.bottom, 8)
                Button {
                    userSettings.finishOB()
                    Task {
                        await SubscriptionService.shared.purchase(productId: sendProduct().rawValue)
                    }
                } label: {
                    Text("Continue")
                        .font(.system(size: 17))
                }
                .buttonStyle(BigButton(width: .infinity, height: 38))
                .padding()
                HStack {
                    Button { 
                        if let url = URL(string: "https://google.com") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("Privacy Policy")
                            .font(.system(size: 13))
                            .tint(.lQuoternary)
                    }
                    Spacer()
                    Button { } label: {
                        Text("\(Image(systemName: "clock")) Cancel Anytime")
                            .font(.system(size: 13))
                            .tint(.lQuoternary)
                    }
                    Spacer()
                    Button {
                        if let url = URL(string: "https://google.com") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("Terms of Use")
                            .font(.system(size: 13))
                            .tint(.lQuoternary)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    func sendProduct() -> Product {
        var product = Product.m3
        if isYearProduct {
            if isTrial {
                product = Product.y3
            } else {
                product = Product.y
            }
        } else {
            if isTrial {
                product = Product.m3
            } else {
                product = Product.m
            }
        }
        return product
    }
}

#Preview {
    PayWallView()
}
