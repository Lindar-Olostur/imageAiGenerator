////
////  TextEditorApproachView.swift
////  aiImageGenerator
////
////  Created by Lindar Olostur on 09.09.2024.
////
//
//import SwiftUI
//
//struct TextEditorApproachView: View {
//    
//    @State private var text: String
//    
//    let placeholder = "Enter Text Here"
//    
//    init() {
//        UITextView.appearance().backgroundColor = .clear
//    }
//    
//    var body: some View {
//        VStack {
//            ScrollView {
//                ZStack(alignment: .topLeading) {
//                    Color.gray
//                        .opacity(0.3)
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                    
//                    Text(text ?? placeholder)
//                        .padding()
//                        .opacity(text == nil ? 1 : 0)
//                    TextEditor(text: Binding($text, replacingNilWith: ""))
//                        .frame(minHeight: 30, alignment: .leading)
//                        .cornerRadius(6.0)
//                        .multilineTextAlignment(.leading)
//                        .padding(9)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    TextEditorApproachView()
//}
//
//public extension Binding where Value: Equatable {
//    
//    init(_ source: Binding<Value?>, replacingNilWith nilProxy: Value) {
//        self.init(
//            get: { source.wrappedValue ?? nilProxy },
//            set: { newValue in
//                if newValue == nilProxy {
//                    source.wrappedValue = nil
//                } else {
//                    source.wrappedValue = newValue
//                }
//            }
//        )
//    }
//}
