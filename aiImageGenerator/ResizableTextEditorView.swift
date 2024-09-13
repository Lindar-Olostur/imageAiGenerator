////
////  ResizableTextEditorView.swift
////  aiImageGenerator
////
////  Created by Lindar Olostur on 06.09.2024.
////
//
//import SwiftUI
//
//struct ResizableTextEditorView: View {
//    @Binding var text: String
//    @State private var textHeight: CGFloat = 144
//    var placeholder: String
//    var align: Alignment
//    
//    var body: some View {
//        GeometryReader { geometry in
//        VStack {
//            ZStack(alignment: align) {
//                BlurView(style: .systemUltraThinMaterialDark)
//                    .cornerRadius(8)
//                
//                
//                CustomTextEditor(text: $text, textHeight: $textHeight, placeholder: placeholder)
//                    .frame(width: geometry.size.width - 40)
//                    .frame(minHeight: 144, maxHeight: textHeight)
//                    .padding(10)
//                    .background(Color.clear)
//                    .cornerRadius(8)
//                    .onChange(of: text) {
//                        adjustTextHeight()
//                    }
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 8)
//                            .stroke(text.isEmpty ? .gray.opacity(0.24) : Color.orange.opacity(0.5), lineWidth: 1)
//                    )
//                    .overlay(
//                        Button(action: {
//                            text = ""
//                        }) {
//                            Image(systemName: "delete.backward")
//                                .foregroundColor(.lSecondary)
//                        }
//                            .padding(10),
//                        alignment: .bottomTrailing
//                    )
//                
//            }
//            .padding()
//            
//            Spacer()
//        }
//    }
//    }
//    
//    private func adjustTextHeight() {
//        let screenWidth = UIScreen.main.bounds.width
//        let newSize = text.boundingRect(
//            with: CGSize(width: screenWidth - 60, height: .greatestFiniteMagnitude),
//            options: .usesLineFragmentOrigin,
//            attributes: [.font: UIFont.systemFont(ofSize: 17)],
//            context: nil
//        )
//        textHeight = max(144, newSize.height + 30)
//    }
//}
//
//#Preview {
//    ResizableTextEditorView(text: .constant("eec e cedec e cedec e cedec e cedec e cedc e ced"), placeholder: "", align: .topLeading)
//}
//import SwiftUI
//import UIKit
//
//struct CustomTextEditor: UIViewRepresentable {
//    @Binding var text: String
//    @Binding var textHeight: CGFloat
//    var placeholder: String
//    
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.backgroundColor = .clear
//        textView.isEditable = true
//        textView.font = UIFont.systemFont(ofSize: 17)
//        textView.isScrollEnabled = false
//        textView.textColor = .white
//        textView.delegate = context.coordinator
//        textView.textColor = .lQuoternary  // Placeholder цвет
//        textView.text = placeholder      // Изначально показываем placeholder
//        
//        // Устанавливаем начальную ширину
//        let screenWidth = UIScreen.main.bounds.width
//        textView.frame.size.width = screenWidth - 60
//        textView.textContainer.lineBreakMode = .byWordWrapping
//                
//        return textView
//    }
//    
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        if text.isEmpty {
//            uiView.text = placeholder
//            uiView.textColor = .lightGray
//        } else if uiView.text == placeholder {
//            uiView.text = text
//            uiView.textColor = .white
//        }
//        
//        // Ограничиваем ширину TextView
//        let screenWidth = UIScreen.main.bounds.width
//        uiView.frame.size.width = screenWidth - 60 // Учитываем отступы
//        
//        updateTextViewHeight(uiView)
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//    
//    private func updateTextViewHeight(_ textView: UITextView) {
//        // Автоматически изменяем высоту textView
//        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: .infinity))
//        DispatchQueue.main.async {
//            self.textHeight = size.height // Обновляем высоту в зависимости от контента
//        }
//    }
//    
//    class Coordinator: NSObject, UITextViewDelegate {
//        var parent: CustomTextEditor
//        
//        init(_ parent: CustomTextEditor) {
//            self.parent = parent
//        }
//        
//        func textViewDidChange(_ textView: UITextView) {
//            if textView.textColor == .lightGray {
//                textView.text = nil
//                textView.textColor = .black
//            }
//            parent.text = textView.text
//            parent.updateTextViewHeight(textView)
//        }
//        
//        func textViewDidBeginEditing(_ textView: UITextView) {
//            if textView.textColor == .lightGray {
//                textView.text = nil
//                textView.textColor = .black
//            }
//        }
//        
//        func textViewDidEndEditing(_ textView: UITextView) {
//            if textView.text.isEmpty {
//                textView.text = parent.placeholder
//                textView.textColor = .lightGray
//            }
//        }
//    }
//}
