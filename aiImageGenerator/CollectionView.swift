import SwiftUI

struct CollectionView: View {
    @State private var showPhotoPicker = false
    @EnvironmentObject var viewModel: ViewModel
    @State private var pickedImage: UIImage?
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack(alignment: .top) {
                    Color.bgPrimary
                        .ignoresSafeArea()
                    if viewModel.imageCollection.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Collection")
                                .bigTextStyle(alignment: .center)
                                .padding(.top, 75)
                                .padding(.bottom, 20)
                            EmptyCollectionView()
                        }
                    } else {
                        ScrollView(showsIndicators: false) {
                            VStack {
                                Text("Collection")
                                    .bigTextStyle(alignment: .center)
                                    .padding(.top, 75)
                                    .padding(.bottom, 40)
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                    ForEach(viewModel.imageCollection.reversed()) { picture in
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
                    }
                        
                }
            }
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
                            viewModel.openPaywall.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "crown.fill")
                                    .font(.system(size: 15))
                                Text("Pro")
                                    .font(.system(size: 18))
                                    .bold()
                            }
                        }
                        .buttonStyle(MainButton(width: 72, height: 24, opacity: 0.0))
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
            viewModel.imageCollection.append(picture)
        } catch {
            print("Error saving image: \(error)")
        }
    }
}

#Preview {
    CollectionView()
        .environmentObject(ViewModel())
}
