//
//  CollectionView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import SwiftUI

struct CollectionView: View {
    @State private var showPhotoPicker = false
    @EnvironmentObject var userSettings: UserSettings
    @State private var pickedImage: UIImage?
    //@State var pictures: [Picture] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack(alignment: .top) {
                    Color.bgPrimary
                        .ignoresSafeArea()
                    if userSettings.imageCollection.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Collection")
                                .headerStyle(alignment: .center)
                                .padding(.top, 75)
                                .padding(.bottom, 20)
                            EmptyCollectionView()
                        }
                    } else {
                        ScrollView(showsIndicators: false) {
                            VStack {
                                Text("Collection")
                                    .headerStyle(alignment: .center)
                                    .padding(.top, 75)
                                    .padding(.bottom, 40)
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                    ForEach(userSettings.imageCollection.reversed()) { picture in
                                        NavigationLink(destination: ImageDetailView(imageUrl: picture.url, picture: picture)) {
                                            ZStack {
                                                ImageCellView(picture: picture)
                                                
                                            }
                                        }
                                    }
                                }
                                .padding()
                                
                            }
                        }
//                        .refreshable {
//                            imageLoader.fetchImages()
//                        }
                    }
                        
                }
            }
//            .toolbarBackground(.bgDim, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showPhotoPicker = true
                    } label: {
                        Image("aiLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 96, height: 28)
                    }
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
//            .fullScreenCover(isPresented: $openPaywall) {
//                PayWallView()
//            }
        }
//        .onAppear(perform: {
//            pictures = userSettings.imageCollection.reversed()
//        })
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker { image in
                self.pickedImage = image
                // Здесь можно сохранить фото и создать Picture
                if let image = image {
                    savePicture(image: image)
                }
            }
        }
    }
    func savePicture(image: UIImage) {
        // Преобразование UIImage в URL нужно добавить здесь
        // Например, сохранить изображение в файловую систему и получить URL

        // Пример кода для сохранения изображения:
        let fileManager = FileManager.default
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        let fileName = UUID().uuidString + ".jpg"
        let fileURL = fileManager.temporaryDirectory.appendingPathComponent(fileName)

        do {
            try data.write(to: fileURL)
            // Создание объекта Picture
            let picture = Picture(
                url: fileURL,
                prompt: "Your prompt",
                negativePrompt: "Your negative prompt",
                size: "\(image.size.width)x\(image.size.height)",
                isUpscaled: false,
                model: "Your model",
                ratio: "\(image.size.width / image.size.height)"
            )
            userSettings.imageCollection.append(picture)
        } catch {
            print("Error saving image: \(error)")
        }
    }
}

#Preview {
    CollectionView()
//        .environmentObject(ImageLoader())
        .environmentObject(UserSettings())
}
