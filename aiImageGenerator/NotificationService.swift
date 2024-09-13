//
//  NotificationService.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 08.09.2024.
//
//
//import Foundation
//import UserNotifications
//
//class NotificationService {
//    static let shared = NotificationService()
//    // Асинхронный запрос статуса разрешения
//    func getNotificationPermissionStatus() async throws -> UNAuthorizationStatus {
//        let settings = await UNUserNotificationCenter.current().notificationSettings()
//        return settings.authorizationStatus
//    }
//    
//    // Асинхронный запрос на разрешение
//    func requestNotificationPermission() async throws -> Bool {
//        let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
//        return granted
//    }
//}
