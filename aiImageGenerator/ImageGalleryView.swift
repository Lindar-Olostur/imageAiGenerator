import SwiftUI

struct ImageGalleryView: View {
    @State var pictures: [Picture] = []

    var body: some View {
            VStack {
                VStack {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(pictures) { imageData in
                                NavigationLink(destination: ImageDetailView(imageUrl: imageData.url, picture: imageData)) {
                                    ImageCellView(picture: imageData)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .background(Color.clear)
    }
}


#Preview {
    ImageGalleryView()
}
