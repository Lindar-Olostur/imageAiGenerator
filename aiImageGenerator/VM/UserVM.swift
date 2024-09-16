//
//  UserVM.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//

import Foundation
import UIKit

class UserSettings: ObservableObject {
    @Published var isOnboardingCompleted = UserDefaults.standard.bool(forKey: "isOnboardingCompleted")
//    {
//        didSet {
//            
//                print("OB status = \(isOnboardingCompleted)")
//        }
//    }
    @Published var sessionCount = UserDefaults.standard.integer(forKey: "sessionCount") {
        didSet {
            UserDefaults.standard.set(sessionCount, forKey: "sessionCount")
        }
    }
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
    @Published var imageCollection: [Picture] = []
//    {
//        didSet {
//            print(imageCollection.map {$0.url})
//        }
//    }
    //[Picture(url: URL(string: "https://via.placeholder.com/300")!, imageData: Data(), prompt: "", negativePrompt: "Negative Negative", size: "480 x 480", isUpscaled: false, model: "Art", ratio: "1:1 - landscape")]
    @Published var selectedTab = Tab.create
    @Published var isPreloaderVisible = true
    @Published var openPaywall = false
    
    @Published var showErrorAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    

    @Published var testGeneration = false
    @Published var testProgress = false
    //    ----------if needed app registration/login
    //    @Published var isRegistred: Bool = false
    //    @Published var password: String = ""
    //    @Published var email: String = ""
    
    init() {
       // print("OB status = \(isOnboardingCompleted)")
        loadUserFromUserDefaults()
        sessionCount += 1
        //print("OB status = \(isOnboardingCompleted)")
    }
    
    func finishOB() {
        UserDefaults.standard.set(true, forKey: "isOnboardingCompleted")
        isOnboardingCompleted = true
        isPreloaderVisible = false
        openPaywall = false
    }
    
    func resetToDefaultValues() {
        //        isRegistred = false
        //        password = ""
        //        email = ""
    }
    
    private func loadUserFromUserDefaults() {
        guard let data = UserDefaults.standard.data(forKey: "imageCollection") else { return }
        do {
            imageCollection = try JSONDecoder().decode([Picture].self, from: data)
            //print("Image collection loaded.")
        } catch {
           // print("Failed to load image collection: \(error)")
        }
        guard let data = UserDefaults.standard.data(forKey: "recentImages") else { return }
        do {
            recentImages = try JSONDecoder().decode([Picture].self, from: data)
            //print("Reсent images loaded.")
        } catch {
           // print("Failed to load image collection: \(error)")
        }
        //        if UserDefaults.standard.object(forKey: "isRegistred") != nil {
        //            self.isRegistred = UserDefaults.standard.bool(forKey: "isRegistred")
        //        }
        //        if let email = UserDefaults.standard.string(forKey: "email") {
        //            self.email = email
        //        }
        //        if let password = UserDefaults.standard.string(forKey: "password") {
        //            self.password = password
        //        }
    }
    
    func saveUserToUserDefaults() {
        do {
            let data = try JSONEncoder().encode(recentImages)
            UserDefaults.standard.set(data, forKey: "recentImages")
           // print("Image collection saved.")
        } catch {
           // print("Failed to save image collection: \(error)")
        }
        do {
            let data = try JSONEncoder().encode(imageCollection)
            UserDefaults.standard.set(data, forKey: "imageCollection")
          //  print("Image collection saved.")
        } catch {
         //   print("Failed to save image collection: \(error)")
        }
        //        UserDefaults.standard.set(isRegistred, forKey: "isRegistred")
        //        UserDefaults.standard.set(password, forKey: "password")
        //        UserDefaults.standard.set(email, forKey: "email")
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
        
        saveUserToUserDefaults()
    }


    func removeImage(by url: URL) {
        // Ищем индекс элемента с нужным URL
        if let index = imageCollection.firstIndex(where: { $0.url == url }) {
            // Если нашли, удаляем элемент по индексу
            imageCollection.remove(at: index)
            saveUserToUserDefaults() // Сохраняем изменения в UserDefaults
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
