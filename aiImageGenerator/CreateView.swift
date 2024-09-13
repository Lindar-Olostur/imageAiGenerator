//
//  CreateView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI
import TipKit
import UIKit

struct CreateView: View {
    @EnvironmentObject var aiService: AiService
    @EnvironmentObject var imageLoader: ImageLoader
    @EnvironmentObject var userSettings: UserSettings
    @State var selectedStyle = GenStyle.art
    @State var positPrompt = ""
    @State var negatPrompt = ""
    @State private var scrollOffset: CGFloat = 0
    @State private var selectedIndex = 0
    @State private var buttonDisabled = true
    
    @State private var openPaywall = false
    var tip = InlineTip2()
    
    init() {
        try? Tips.configure()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack(alignment: .top) {
                    Color.bgPrimary
                    Image(.create)
                        .resizable()
                        .scaledToFit()
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.clear, location: 0),
                                    .init(color: Color(.bgPrimary), location: 0.75)
                                ]),
                                startPoint: UnitPoint(x: 0.5, y: 0.6),
                                endPoint: .bottom
                            )
                        )
                }
                .ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Create AI Image")
                            .headerStyle(alignment: .center)
                            .padding(.top, 75)
                            .padding(.bottom, 20)
                        Text("Enter Prompt")
                            .font(.system(size: 17))
                            .foregroundStyle(.white)
                            .bold()
                            .padding(.horizontal)
                            .padding(.bottom, -16)
                        TextEditorView(text: $positPrompt, placeholder: "What do you want to generate?")
                        
                        HStack {
                            Text("Style")
                                .font(.system(size: 17))
                                .foregroundStyle(.white)
                                .bold()
                                .padding(.horizontal)
                                .padding(.bottom, -6)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(GenStyle.allCases, id: \.self) { style in
                                    StyleCellView(
                                        active: style == selectedStyle,
                                        label: style.rawValue,
                                        onTap: {
                                            let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
                                                        impactFeedback.impactOccurred()
                                            selectedStyle = style
                                        }
                                    )
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .padding(.horizontal)
                        
                        ToggleFieldView(textFieldInput: $negatPrompt)
                        VStack {
                            if buttonDisabled {
                                Button {
                                    //
                                } label: {
                                    Text("\(Image(systemName: "pencil.line")) Create")
                                        .font(.system(size: 20))
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(Color(.lQuintuple))
                                .background(Color.cSecondaryLight)
                                .cornerRadius(10, corners: .allCorners)
                                .padding(.horizontal)
                                .disabled(buttonDisabled)
                            } else {
                                Button {
                                    let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
                                                impactFeedback.impactOccurred()
                                    Task {
                                        await aiService.generateImage(prompt: positPrompt)
                                    }
                                    userSettings.testProgress = true
                                } label: {
                                    Text("\(Image(systemName: "pencil.line")) Create")
                                        .font(.system(size: 18))
                                }
                                .buttonStyle(BigButton(width: .infinity, height: 38))
                                .padding(.horizontal)
                            }
                        }
                    }
                    .background(GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                scrollOffset = geometry.frame(in: .global).minY
                            }
                            .onChange(of: geometry.frame(in: .global).minY) { oldValue, newValue in
                                scrollOffset = newValue
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                    })
                    VStack {
                        HStack(spacing: 22) {
                            Button {
                                withAnimation {
                                    selectedIndex = 0
                                }
                            } label: {
                                Text("Inspirations")
                                    .font(.system(size: 24))
                                    .foregroundStyle(selectedIndex == 0 ? .white : .lQuoternary)
                                    .background(
                                        Color.cPrimaryLight
                                            .frame(height: 1)
                                            .offset(y: 20)
                                            .opacity(selectedIndex == 0 ? 1 : 0)
                                    )
                            }
                            Button {
                                withAnimation {
                                    selectedIndex = 1
                                }
                            } label: {
                                VStack {
                                    Text("Recents")
                                        .font(.system(size: 24))
                                    .foregroundStyle(selectedIndex == 1 ? .white : .lQuoternary)
                                    .background(
                                        Color.cPrimaryLight
                                            .frame(height: 1)
                                            .offset(y: 20)
                                            .opacity(selectedIndex == 1 ? 1 : 0)
                                    )
                                }
                            }
                        }
                        
                        Spacer()
                        
                        if selectedIndex == 0 {
                            ImageGalleryView(pictures: imageLoader.images)
                                .transition(.move(edge: .leading))
                        } else {
                            ImageGalleryView(pictures: userSettings.recentImages.reversed())
                                .transition(.move(edge: .trailing))
                        }
                    }
                    .padding(.top, 40)
                }
                .scrollIndicators(.hidden)
                VStack {
                    TipView(tip, arrowEdge: .top)
                        .frame(width: 278)
                        .tint(.lTertiary)
                        .tipBackground(Color(.cPrimaryLight))
                        .offset(y: 10)
                }
            }
//            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("aiLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96, height: 28)
                }
                if !SubscriptionService.shared.hasSubs {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            userSettings.openPaywall.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "crown.fill")
                                    .font(.system(size: 15))
                                Text("Pro")
                                    .font(.system(size: 18))
                                    .bold()
                            }
                        }
                        .buttonStyle(BigButton(width: 72, height: 24, opacity: 0.0))
                        .scaleEffect(0.8)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                            .tint(.cPrimaryLight)
                    }
                }
            }
        }
        .onTapGesture {
            // Закрыть клавиатуру
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
//        .fullScreenCover(isPresented: $openPaywall) {
//            PayWallView()
//        }
        .onChange(of: positPrompt) {
            if positPrompt.isEmpty {
                buttonDisabled = true
            } else {
                buttonDisabled = false
            }
        }
        .fullScreenCover(isPresented: $openPaywall) {
            PayWallView()
        }
        .onReceive(userSettings.$openPaywall) { value in
            openPaywall = value
        }
        .onAppear(perform: {
           // print("SUBS IS - \(SubscriptionService.shared.hasSubs)")
        })
    }
}

#Preview {
    CreateView()
        .environmentObject(AiService())
        .environmentObject(ImageLoader())
        .environmentObject(UserSettings())
}


