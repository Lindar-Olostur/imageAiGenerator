//
//  ImageGenerationView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 07.09.2024.
//

import SwiftUI

struct ImageGenerationView: View {
    @State private var prompt: String = "edw"
    @State private var generatedImages: [UIImage] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            // Поле для ввода текста
            TextField("Enter your prompt", text: $prompt)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Индикатор загрузки
            if isLoading {
                ProgressView("Generating Images...")
            }

            // Отображение ошибок
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            // Отображение нескольких сгенерированных картинок
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(generatedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding()
                    }
                }
            }

            // Кнопка для генерации изображения
            Button("Generate Images") {
                Task {
                    await generateImages(for: prompt)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(prompt.isEmpty) // Отключаем кнопку, если промпт пуст
        }
        .padding()
    }

    // Асинхронная функция для отправки промпта и получения нескольких картинок
    func generateImages(for prompt: String) async {
        isLoading = true
        errorMessage = nil
        
        // Пример URL API
        let apiUrl = URL(string: "https://example.com/generate-images")!

        // Создание запроса
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Данные для отправки (промпт)
        let body: [String: Any] = ["prompt": prompt]
        do {
            // Пробуем сериализовать JSON
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            errorMessage = "Failed to encode the request body: \(error.localizedDescription)"
            isLoading = false
            return
        }

        do {
            // Выполняем запрос к серверу
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Проверка статуса HTTP ответа
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                errorMessage = "Server returned an error: \(httpResponse.statusCode)"
                isLoading = false
                return
            }

            // Пробуем декодировать ответ от сервера
            guard let decodedResponse = try? JSONDecoder().decode([String].self, from: data) else {
                errorMessage = "Failed to decode the server response."
                isLoading = false
                return
            }

            // Пробуем декодировать base64 в изображения
            let decodedImages = decodedResponse.compactMap { base64String -> UIImage? in
                if let imageData = Data(base64Encoded: base64String) {
                    return UIImage(data: imageData)
                } else {
                    print("Failed to decode base64 string: \(base64String)")
                    return nil
                }
            }

            // Проверяем, удалось ли получить изображения
            if decodedImages.isEmpty {
                errorMessage = "No valid images were generated."
            } else {
                generatedImages = decodedImages
            }

        } catch {
            // Если произошла ошибка запроса
            errorMessage = "Request failed: \(error.localizedDescription)"
        }

        isLoading = false
    }
}

#Preview {
    ImageGenerationView()
}
