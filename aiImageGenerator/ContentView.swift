//
//  ContentView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 06.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = APIViewModel()
        
        var body: some View {
            VStack(spacing: 20) {
                Button("POST: Добавить в избранное") {
                    viewModel.addToFavorites()
                }
                .disabled(viewModel.isLoading)
                
                Button("GET: Получить избранное") {
                    viewModel.getFavorites()
                }
                .disabled(viewModel.isLoading)
                
                if viewModel.isLoading {
                    ProgressView()
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                } else if !viewModel.responseMessage.isEmpty {
                    Text(viewModel.responseMessage)
                        .foregroundColor(.green)
                }
                
                ScrollView {
                    Text(viewModel.rawResponse)
                        .font(.system(size: 14, design: .monospaced))
                }
            }
            .padding()
        }
    }

    class APIViewModel: ObservableObject {
        @Published var errorMessage: String = ""
        @Published var responseMessage: String = ""
        @Published var rawResponse: String = ""
        @Published var isLoading: Bool = false
        
        private let userId = "111122233"
        private let resultId = "666"
        
        func addToFavorites() {
            isLoading = true
            errorMessage = ""
            responseMessage = ""
            rawResponse = ""
            
            let urlString = "https://nexgendev.space/api/v2/favourite"
            guard let url = URL(string: urlString) else {
                errorMessage = "Invalid URL"
                isLoading = false
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Создаем массив данных для отправки
            let dataArray: [[String: Any]] = [
                [
                    "id": "555",
                    "url": "https://via.placeholder.com/300"
                ]
            ]
            
            // Создаем тело запроса
            let bodyData: [String: Any] = [
                "userId": userId,
                "resultId": resultId,
                "data": dataArray
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: bodyData, options: [])
                request.httpBody = jsonData

                // Логируем тело запроса для проверки
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("Request body:\n\(jsonString)")
                }
            } catch {
                errorMessage = "Failed to encode JSON"
                isLoading = false
                return
            }

            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if let error = error {
                        self?.errorMessage = "Error: \(error.localizedDescription)"
                    } else if let httpResponse = response as? HTTPURLResponse {
                        self?.responseMessage = "Status code: \(httpResponse.statusCode)"
                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
                            self?.rawResponse = "Raw response:\n\(dataString)"
                            print("Raw response:\n\(dataString)")
                        }
                    }
                }
            }.resume()
        }


        
        func getFavorites() {
            isLoading = true
            errorMessage = ""
            responseMessage = ""
            rawResponse = ""
            
            let urlString = "https://nexgendev.space/api/v2/favourites?userId=\(userId)"
            guard let url = URL(string: urlString) else {
                errorMessage = "Invalid URL"
                isLoading = false
                return
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if let error = error {
                        self?.errorMessage = "Error: \(error.localizedDescription)"
                    } else if let httpResponse = response as? HTTPURLResponse {
                        self?.responseMessage = "Status code: \(httpResponse.statusCode)"
                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
                            self?.rawResponse = "Raw response:\n\(dataString)"
                            print("Raw response:\n\(dataString)")
                        }
                    }
                }
            }.resume()
        }
    }


#Preview {
    ContentView()
}

//import Foundation
//
//enum FavoritesError: Error {
//    case invalidURL
//    case networkError(Error)
//    case invalidResponse
//    case decodingError(Error)
//}
//
//struct FavoritesService {
//    private let baseURL = "https://nexgendev.space/api/v2"
//    private let userId: String
//    
//    init(userId: String) {
//        self.userId = userId
//    }
//    
//    func addToFavorites(resultId: String) async throws {
//        let urlString = "\(baseURL)/favourite?userId=\(userId)&resultId=\(resultId)"
//        guard let url = URL(string: urlString) else {
//            throw FavoritesError.invalidURL
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        
//        let (_, response) = try await URLSession.shared.data(for: request)
//        
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode) else {
//            throw FavoritesError.invalidResponse
//        }
//    }
//    
//    func getFavorites() async throws -> [FavoriteItem] {
//        let urlString = "\(baseURL)/favourites?userId=\(userId)"
//        guard let url = URL(string: urlString) else {
//            throw FavoritesError.invalidURL
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode) else {
//            throw FavoritesError.invalidResponse
//        }
//        
//        do {
//            let favorites = try JSONDecoder().decode([FavoriteItem].self, from: data)
//            return favorites
//        } catch {
//            throw FavoritesError.decodingError(error)
//        }
//    }
//}
//
//struct FavoriteItem: Codable {
//    let id: String
//    let url: String
//    // Добавьте другие свойства, которые возвращает API
//}
