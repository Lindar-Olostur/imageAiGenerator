//
//  ImageDetailView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI
import Photos
import TipKit

struct ImageDetailView: View {
    @EnvironmentObject var aiService: AiService
    @EnvironmentObject var imageLoader: ImageLoader
    @EnvironmentObject var userSettings: UserSettings
    @Environment(\.presentationMode) var presentationMode
    @State private var openPaywall = false
    @State private var openUpscale = false
    @State private var toastText = ""
    @State private var showToast = false
//    @Binding var generatedImages: [Picture] = []
    let pasteboard = UIPasteboard.general
    var isFavorite = false
    //var prompt = ""
    let imageUrl: URL
    @State var picture: Picture?
    var tip = InlineTip()
    
    
    var body: some View {
//        NavigationStack {
            ZStack(alignment: .top) {
                Color.bgPrimary.ignoresSafeArea()
                VStack {
                    ScrollView(showsIndicators: false) {
                        AsyncImage(url: imageUrl) { image in
                            ZStack(alignment: .top) {
                                image
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .cornerRadius(10, corners: .allCorners)
                                    .navigationBarTitleDisplayMode(.inline)
                                
                                HStack {
                                    Button {
                                        DispatchQueue.global(qos: .background).async {
                                            downloadImage(from: URL(string: imageUrl.absoluteString)!) { downloadedImage in
                                                if let image = downloadedImage {
                                                    saveImageToGallery(image)
                                                }
                                            }
                                            DispatchQueue.main.async {
                                                    toastText = "Saved to gallery"
                                                    animateToast()
                                                }
                                            }
                                    } label: {
                                        ZStack {
                                            BlurView(style: .systemThinMaterialDark)
                                            Image(systemName: "arrow.down.to.line")
                                                .tint(.white)
                                        }
                                        .frame(width: 36, height: 36)
                                        .cornerRadius(6, corners: .allCorners)
                                    }
                                    Spacer()
                                    ShareLink(item: imageUrl) {
                                        ZStack {
                                            BlurView(style: .systemThinMaterialDark)
                                            Image(systemName: "square.and.arrow.up")
                                                .tint(.white)
                                        }
                                        .frame(width: 36, height: 36)
                                        .cornerRadius(6, corners: .allCorners)
                                    }
                                    Button {
                                        if userSettings.checkCollection(url: imageUrl) {
                                            userSettings.removeImage(by: imageUrl)
                                            toastText = "Removed from “Profile”"
                                            withAnimation(.easeIn(duration: 1)) {
                                                showToast = true
                                            }
                                        } else {
                                            DispatchQueue.main.async {
                                                userSettings.addImage(url: imageUrl, prompt: "", negativePrompt: "", width: 1, height: 1, isUpscaled: false, model: "", ratio: "")
                                            }
                                            toastText = "Added to “Profile”"
                                            animateToast()
                                        }
                                    } label: {
                                        ZStack {
                                            BlurView(style: .systemThinMaterialDark)
                                            Image(systemName: userSettings.checkCollection(url: imageUrl) ? "heart.fill" : "heart")
                                                .foregroundColor(userSettings.checkCollection(url: imageUrl) ? .cRed : .lQuoternary)
                                        }
                                        .frame(width: 36, height: 36)
                                        .cornerRadius(6, corners: .allCorners)
                                    }
                                }
                                .padding(8)
                            }
                        } placeholder: {
                            GeometryReader { geometry in
                                ProgressView()
                                    .scaleEffect(3)
                                    .frame(
                                        width: min(geometry.size.width, geometry.size.height),
                                        height: min(geometry.size.width, geometry.size.height)
                                    )
                                    .position(
                                        x: geometry.size.width / 2,
                                        y: geometry.size.height / 2
                                    )
                            }
                            .aspectRatio(1, contentMode: .fit)
                        }
                        HStack {
                            Text("Prompt")
                                .font(.system(size: 17))
                                .foregroundStyle(.white)
                                .bold()
                                .padding(.bottom, -6)
                            Spacer()
                            Button {
                                toastText = "Prompt copied"
                                animateToast()
                                pasteboard.string = picture?.prompt ?? ""
                            } label: {
                                Text("Copy")
                                    .font(.system(size: 15))
                                    .foregroundStyle(.lSecondary)
                                Image(systemName: "doc.on.doc")
                            }
                        }
                        .padding(.vertical)
                        Text(picture?.prompt ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.lQuoternary)
                            .padding(.horizontal, 15)
                            .padding(.vertical)
                            .background(Color.bgTertiary)
                            .cornerRadius(10, corners: .allCorners)
                        if picture != nil {
                            InfosFieldView(picture: picture!)
                        }
                        Text("More images like this")
                            .headerStyle(alignment: .leading)
                            .padding(.top, 55)
                            .padding(.bottom, 8)
                        VStack {
                            ImageGalleryView(pictures: imageLoader.images)
                        }
                        .background(Color.clear)
                        
                    }
                    .padding()
                    .gesture(
                        DragGesture()
                            .onEnded { gesture in
                                if gesture.translation.width > 50 {
                                    // Свайп вправо
                                    withAnimation {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            })
                    if picture != nil && !picture!.isUpscaled {
                        Button {
                            openUpscale.toggle()
                            picture!.isUpscaled = true
                            changeUpscale(true, picture!.url)
                        } label: {
                            Text("\(Image(systemName: "arrow.up.backward.and.arrow.down.forward")) Upscale")
                                .font(.system(size: 17))
                        }
                        .buttonStyle(BigButton(width: .infinity, height: 38))
                        .padding(.horizontal)
                    }
                }
                if showToast {
                    ToastView(text: $toastText)
                        .transition(.opacity)
                        .animation(.easeIn(duration: 1), value: showToast)
                        .frame(alignment: .top)
                        .zIndex(1)
                }
                VStack {
                    TipView(tip, arrowEdge: .trailing)
                        .frame(width: 278)
                        .tint(.lTertiary)
                        .tipBackground(Color(.cPrimaryLight))
                        .offset(y: -3)
                }
            }
//        }
        .onAppear {
            try? Tips.configure()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: { presentationMode.wrappedValue.dismiss() }))
        .toolbar {
            if !SubscriptionService.shared.hasSubs {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        DispatchQueue.main.async {
                            if userSettings.testProgress {
                                presentationMode.wrappedValue.dismiss()
                                userSettings.testProgress = false
                            }
                            userSettings.openPaywall.toggle()
                        }
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
        }
        .fullScreenCover(isPresented: $openUpscale) {
            UpscaleProgressView(isOpen: $openUpscale)
                .background(BackgroundClearView())
        }
        .onAppear(perform: {
            print(picture?.isUpscaled ?? "no picture")
        })
    }
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(uiImage)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            task.resume()
        }

        func saveImageToGallery(_ image: UIImage) {
            // Проверяем разрешение
            PHPhotoLibrary.requestAuthorization { status in
                guard status == .authorized else {
                    print("Нет разрешения на доступ к фотогалерее")
                    return
                }

                // Генерируем уникальное имя файла
                let imageName = "Image_\(Date().timeIntervalSince1970).jpg"

                // Сохраняем изображение в галерею
                PHPhotoLibrary.shared().performChanges({
                    let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
                    request.creationDate = Date()
                    request.location = nil
                }) { success, error in
                    if success {
                        print("Изображение успешно сохранено в галерею с именем: \(imageName)")
                    } else if let error = error {
                        print("Ошибка при сохранении изображения: \(error.localizedDescription)")
                    }
                }
            }
        }
    func changeUpscale(_ upscale: Bool, _ url: URL) {
        if let existingIndex = userSettings.imageCollection.firstIndex(where: { $0.url == url }) {
            userSettings.imageCollection[existingIndex].isUpscaled = upscale
            userSettings.saveUserToUserDefaults()
        } else {
            if let existingIndex = userSettings.recentImages.firstIndex(where: { $0.url == url }) {
                userSettings.recentImages[existingIndex].isUpscaled = upscale
                userSettings.saveUserToUserDefaults()
            } else {
                if let existingIndex = aiService.genImages.firstIndex(where: { $0.url == url }) {
                    aiService.genImages[existingIndex].isUpscaled = upscale
                }
                if let existingIndex = imageLoader.images.firstIndex(where: { $0.url == url }) {
                    imageLoader.images[existingIndex].isUpscaled = upscale
                }
            }
        }
    }
    func animateToast() {
        withAnimation(.easeIn(duration: 1)) {
            showToast = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.easeOut(duration: 1)) {
                showToast = false
            }
        }
    }
}


#Preview {
    ImageDetailView(imageUrl: URL(string: "https://via.placeholder.com/300")!, picture: nil)
        .environmentObject(AiService())
        .environmentObject(ImageLoader())
        .environmentObject(UserSettings())
}

struct BackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.left")
                    .tint(.cPrimaryLight)
                Text("Back")
                    .foregroundColor(.cPrimaryLight)
            }
        }
    }
}

