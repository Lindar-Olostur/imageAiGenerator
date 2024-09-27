import Foundation
import UIKit

class ViewModel: ObservableObject {
    @Published var isOBoardingFinished = UserDefaults.standard.bool(forKey: "OB")
    @Published var imageCollection: [Picture] = []
    @Published var selectedTab = Tab.create
    @Published var isStartScreenVisible = true
    @Published var openPaywall = false
    @Published var sessionCounter = UserDefaults.standard.integer(forKey: "Count")
    {
        didSet {
            UserDefaults.standard.set(sessionCounter, forKey: "Count")
        }
    }
    @Published var testGeneration = false
    @Published var testProgress = false
    @Published var recentImages: [Picture] = []
    {
        didSet {
            if recentImages.count > 20 {
                for _ in 1...(recentImages.count - 20) {
                    recentImages.removeFirst()
                }
            }
        }
    }
    
    init() {
        loadFromUD()
        sessionCounter += 1
    }
    
    func finishOB() {
        UserDefaults.standard.set(true, forKey: "OB")
        isOBoardingFinished = true
        isStartScreenVisible = false
        openPaywall = false
    }

    func saveToUD() {
        do {
            let data = try JSONEncoder().encode(recentImages)
            UserDefaults.standard.set(data, forKey: "recentImages")
        } catch {
            print("Failed to save recentImages: \(error)")
        }
        
        do {
            let data = try JSONEncoder().encode(imageCollection)
            UserDefaults.standard.set(data, forKey: "imageCollection")
        } catch {
            print("Failed to save image collection: \(error)")
        }
    }
    
    func loadFromUD() {
        guard let data = UserDefaults.standard.data(forKey: "imageCollection") else { return }
        do {
            imageCollection = try JSONDecoder().decode([Picture].self, from: data)
        } catch {
           print("Failed to load image collection: \(error)")
        }
        
        guard let data = UserDefaults.standard.data(forKey: "recentImages") else { return }
        do {
            recentImages = try JSONDecoder().decode([Picture].self, from: data)
        } catch {
            print("Failed to load pictures: \(error)")
        }
    }
    
    func addImage(url: URL, prompt: String, negativePrompt: String, size: String, isUpscaled: Bool, model: String, ratio: String) {
        let picture = Picture(
            url: url,
            prompt: prompt,
            negativePrompt: negativePrompt,
            size: size,
            isUpscaled: isUpscaled,
            model: model,
            ratio: ratio
        )
        
        // Проверяем, есть ли картинка с таким же URL в коллекции
        if let existingIndex = imageCollection.firstIndex(where: { $0.url == url }) {
            imageCollection[existingIndex] = picture
        } else {
            imageCollection.append(picture)
        }
        
        saveToUD()
    }


    func removeImage(by url: URL) {
        // Ищем индекс элемента с нужным URL
        if let index = imageCollection.firstIndex(where: { $0.url == url }) {
            // Если нашли, удаляем элемент по индексу
            imageCollection.remove(at: index)
            saveToUD() // Сохраняем изменения в UserDefaults
            print("Image removed.")
        } else {
            print("Image not found.")
        }
    }
    
    func checkCollection(url: URL) -> Bool {
        imageCollection.contains { picture in
            picture.url == url
        }
    }
    
}
