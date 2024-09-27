import Foundation
import AppTrackingTransparency
import UIKit

final class TrackingAuthorizationService {
    
    // Запрос на авторизацию отслеживания
    func requestAuthorization(completion: @escaping (() -> ())) {
        clearObserver()
        
        ATTrackingManager.requestTrackingAuthorization { [weak self] status in
            if status == .denied, ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                debugPrint("Обнаружена ошибка авторизации в iOS 17.4")
                self?.setupObserver(completion: completion)
                return
            }
            debugPrint("Статус = \(status)")
        }
    }

    private weak var observer: NSObjectProtocol?

    // Настройка наблюдателя для уведомления о возвращении в активное состояние
    private func setupObserver(completion: @escaping (() -> ())) {
        clearObserver()
        observer = NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main,
            using: {[weak self] _ in
                self?.requestAuthorization(completion: completion)
                completion()
            })
    }

    // Удаление наблюдателя
    private func clearObserver() {
        if let observer {
            NotificationCenter.default.removeObserver(observer)
        }
        observer = nil
    }

}
