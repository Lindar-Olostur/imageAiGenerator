import SwiftUI

class ImageLoader: ObservableObject {
    @Published var images: [Picture] = []
    
    init() {
        fetchImages()
    }
    
    func fetchImages() {
        let group = DispatchGroup()
        for _ in 1...20 {
            let randomSize = Int.random(in: 200...300)
            let imageURL = "https://loremflickr.com/\(randomSize)/\(randomSize)"
            
            group.enter()
            getFinalImageURL(from: imageURL) { finalURL in
                if let finalURL = finalURL {
                    DispatchQueue.main.async {
                        self.images.append(Picture(
                            url: finalURL,
                            prompt: "No prompt",
                            negativePrompt: "no negative prompt",
                            size: "\(randomSize)x\(randomSize)",
                            isUpscaled: false,
                            model: "Art",
                            ratio: "any"
                        ))
                    }
                }
                group.leave()
            }
        }
        
        // Ожидание завершения всех запросов
        group.notify(queue: .main) {
            print("Все изображения загружены!")
        }
    }
    
    // Получение финального URL изображения
    func getFinalImageURL(from url: String, completion: @escaping (URL?) -> Void) {
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { _, response, _ in
            if let finalURL = response?.url {
                completion(finalURL)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
