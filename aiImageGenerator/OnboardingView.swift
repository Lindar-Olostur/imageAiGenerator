////
////  OnboardingView.swift
////  aiImageGenerator
////
////  Created by Lindar Olostur on 06.09.2024.
////
//
//import SwiftUI
//
//struct OnboardingView: View {
//    @State private var currentPage = 0
//    
//    var body: some View {
//        ZStack {
//            Color.clear
//            NavigationView {
//                VStack {
//                    ImageGalleryView()
//                    Spacer()
//                    ResizableTextEditorView(placeholder: "", align: .top)
//                        .onTapGesture {
//                            // Не закрывать клавиатуру при тапе внутри TextEditor
//                        }
//                    Spacer()
//                    NavigationLink(destination: YellowScreen()) {
//                        Text("Перейти на Жёлтый экран")
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                }
//                .navigationTitle("Белый")
//            }
//            .gesture(
//                DragGesture()
//                    .onChanged { value in
//                        if value.translation.height > 30 {
//                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                        }
//                    }
//            )
//            .ignoresSafeArea()
//            .tabViewStyle(.page(indexDisplayMode: .never))
//        }
//        .onTapGesture {
//            // Закрыть клавиатуру
//            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//        }
//    }
//}
//
//
//struct OnboardingScreenView: View {
//    let color: Color
//    let title: String
//    let nextStep: () -> Void
//    
//    var body: some View {
//        ZStack {
//            color.edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                Spacer()
//                Text(title)
//                    .customText(alignment: .center, size: 33, color: .yellow, weight: .bold)
//                Spacer()
//                ResizableTextEditorView(placeholder: "", align: .bottom)
//                Spacer()
//                Button(action: nextStep) {
//                    Text("Continue")
//                }
//                .buttonStyle(BigButton(width: .infinity, height: 17))
//                Spacer()
//            }
//        }
//    }
//}
//
//#Preview {
//    OnboardingView()
//}
//
////.gesture(
////                DragGesture()
////                    .onChanged { value in
////                        let horizontalAmount = value.translation.width
////                        let verticalAmount = value.translation.height
////
////                        // Пример: Скрыть клавиатуру только при горизонтальном свайпе вправо
////                        if horizontalAmount > 0 && abs(horizontalAmount) > abs(verticalAmount) {
////                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
////                        }
////                    }
////            )
