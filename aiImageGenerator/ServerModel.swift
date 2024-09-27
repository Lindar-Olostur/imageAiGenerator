import Foundation

// Главная модель для JSON ответа
struct RootResponse: Codable {
    let error: Bool
    let data: DataObject
}

// Модель для объекта "data"
struct DataObject: Codable {
    let requestId: String
    let status: String
    let error: String?
    let request: RequestObject
    let result: [ResultObject]
}

// Модель для объекта "request"
struct RequestObject: Codable {
    let profileId: Int
    let app: String
    let version: String
    let userPrompt: String
    let productionPrompt: String
    let ai: String
}

// Модель для объекта "result" (пока пустой, так как результат ещё не пришёл)
struct ResultObject: Codable {
    let id: String
    let url: String
}

