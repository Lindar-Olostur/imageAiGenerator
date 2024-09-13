//
//  AiService.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 10.09.2024.
//

import Foundation

class AiService: ObservableObject {
    @Published var progress: Double = 0.0
//    {
//        didSet {
//            print(progress)
//        }
//    }
    var timer: Timer?
    @Published var genImages: [Picture] = []
    @Published var generatedImageData: [ResultObject] = []
    @Published var errorMessage: String? = nil
    
    // Функция для отправки запроса на генерацию картинки
    func generateImage(prompt: String) async {
        DispatchQueue.main.async {
            self.progress = 0.0
        }
        
        let generateURLString =  "https://nexgendev.space/api/v2/generate?profileId=1&userId=11232323&prompt=\(prompt.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&lang=en"
        
        guard let url = URL(string: generateURLString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Некорректный URL"
            }
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let rootResponse = try decoder.decode(RootResponse.self, from: data)
                    
                    let requestId = rootResponse.data.requestId
                    //let status = rootResponse.data.status
                    
                    await fetchResult(requestId: requestId)
                    
                    
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Ошибка декодирования JSON: \(error.localizedDescription)"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Ошибка на сервере"
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    
    // Функция для получения результата
    func fetchResult(requestId: String) async {
        let resultURLString = "https://nexgendev.space/api/v2/result?requestId=\(requestId)"
        
        guard let url = URL(string: resultURLString) else {
            print("Некорректный URL")
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        // Используем цикл для повторных запросов
        while true {
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    let decoder = JSONDecoder()
                    let rootResponse = try decoder.decode(RootResponse.self, from: data)
                    
                    if !rootResponse.data.result.isEmpty {
                        //print(rootResponse.data)
                        
                        Task {
                            var newImages = [Picture]()
                            
                            for (_, z) in rootResponse.data.result.enumerated() {
                                if z.url != "", let url = URL(string: z.url) {
                                    do {
                                        let (data, _) = try await URLSession.shared.data(from: url)
                                        let picture = Picture(
                                            url: url,
                                            prompt: rootResponse.data.request.userPrompt,
                                            negativePrompt: "no negative prompt",
                                            size: "1024x1024",
                                            isUpscaled: false,
                                            model: "Art",
                                            ratio: "1:1"
                                        )
                                        print(picture)
                                        newImages.append(picture)
                                    } catch {
                                        print("Ошибка при загрузке данных для URL \(z.url): \(error)")
                                    }
                                }
                            }
                            
                            DispatchQueue.main.async {
                                self.genImages = newImages
                                self.progress = 1.0
                            }
                        }
                        
                        break
                    }
                } else {
                    errorMessage = "Ошибка на сервере"
                    print("Ошибка на сервере")
                    break
                }
            } catch {
                print("Ошибка при запросе: \(error.localizedDescription)")
                break
            }
            
            // Задержка перед следующим запросом (например, 5 секунд)
            try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
        }
    }
    
    func startProgressSimulation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if self.progress < Double.random(in: 0.91...0.99) {
                    self.progress += Double.random(in: 0.001...0.008)
                }
            }
        }
    }
    
    func decodeRootResponse(from data: Data) -> RootResponse? {
        do {
            let decoder = JSONDecoder()
            let rootResponse = try decoder.decode(RootResponse.self, from: data)
            return rootResponse
        } catch {
            print("Ошибка декодирования JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    func sendFavouriteImages() {
        // URL запроса с query параметрами
        let favouriteURLString = "https://nexgendev.space/api/v2/favourite?userId=111122233&resultId=9ffdd8c1-37d0-4be3-8cbb-09b367eb15dd"
        
        // Убедимся, что URL корректен
        guard let url = URL(string: favouriteURLString) else {
            print("Некорректный URL")
            return
        }
        
        // Создаем запрос
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        
        // Отправляем запрос
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Проверяем наличие ошибок
            guard let data = data else {
                print("Ошибка: \(String(describing: error))")
                return
            }
            
            // Обрабатываем ответ сервера
            if let responseString = String(data: data, encoding: .utf8) {
                print("Ответ сервера: \(responseString)")
            } else {
                print("Не удалось декодировать ответ")
            }
        }
        
        // Запускаем задачу
        task.resume()
    }


}

