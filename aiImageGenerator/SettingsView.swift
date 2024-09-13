//
//  SettingsView.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 12.09.2024.
//

import SwiftUI
import StoreKit
import UserNotifications

struct SettingsView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var userSettings: UserSettings
    @State private var isShareSheetShowing = false
    @Environment(\.presentationMode) var presentationMode
    @State var notifStatus = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Color.bgPrimary
                    .ignoresSafeArea()
                VStack {
                    Text("Settings")
                        .headerStyle(alignment: .center)
                        .padding(.top, 75)
                    List {
                        if !SubscriptionService.shared.hasSubs {
                            Section {
                                SettingsRow(iconName: "arrow.clockwise", title: "Restore purchases")
                                    .contentShape(Rectangle())
                                    .listRowBackground(Color.bgTertiary)
                                    .onTapGesture {
                                        Task {
                                            await SubscriptionService.shared.restorePurchases()
                                        }
                                    }
                            }
                        }
                        Section {
                            SettingsRow(iconName: "star.bubble", title: "Rate our app")
                                .contentShape(Rectangle())
                                .listRowSeparatorTint(.lQuoternary.opacity(0.4))
                                .listRowBackground(Color.bgTertiary)
                                .onTapGesture {
                                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                        SKStoreReviewController.requestReview(in: scene)
                                    }
                                }
                            ShareLink(item: URL(string: "https://apps.apple.com/ru/app/flix-reels-maker/id6474242365")!) {
                                SettingsRow(iconName: "square.and.arrow.up", title: "Share with friends")
                                    .contentShape(Rectangle())
                            }
                            .listRowBackground(Color.bgTertiary)
                            HStack {
                                SettingsIcon(iconName: "bell.badge.fill")
                                    .padding(.trailing, 8)
                                Text("Notifications")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 17))
                                Spacer()
                                Toggle("", isOn: $notifStatus)
                                    .toggleStyle(SwitchToggleStyle(tint: Color.cPrimaryLight))
                                    .onChange(of: notifStatus) { newValue in
                                        if newValue {
                                            requestNotificationPermission()
                                        } else {
                                            openAppSettings()
                                        }
                                    }
                            }
                            .listRowSeparatorTint(.lQuoternary.opacity(0.4))
                            .listRowBackground(Color.bgTertiary)
                            SettingsRow(iconName: "envelope", title: "Contact us")
                                .contentShape(Rectangle())
                                .listRowBackground(Color.bgTertiary)
                                .listRowSeparatorTint(.lQuoternary.opacity(0.4))
                                .onTapGesture {
                                    if let url = URL(string: "https://google.com") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                        }
                        Section {
                            SettingsRow(iconName: "doc.text", title: "Usage Policy")
                                .contentShape(Rectangle())
                                .listRowBackground(Color.bgTertiary)
                                .listRowSeparatorTint(.lQuoternary.opacity(0.4))
                                .onTapGesture {
                                    if let url = URL(string: "https://google.com") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            SettingsRow(iconName: "lock.shield", title: "Privacy Policy")
                                .contentShape(Rectangle())
                                .listRowBackground(Color.bgTertiary)
                                .onTapGesture {
                                    if let url = URL(string: "https://google.com") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.bgPrimary)
                    .environment(\.defaultMinListRowHeight, 60)
                    .listSectionSpacing(20)
                }
                Text("App Version: 1.0.0")
                    .foregroundColor(.lTertiary)
                    .font(.footnote)
                    .padding(.bottom, 15)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(action: { presentationMode.wrappedValue.dismiss() }))
            .toolbar {
                if !SubscriptionService.shared.hasSubs {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            DispatchQueue.main.async {
                                if userSettings.testProgress {
                                    //presentationMode.wrappedValue.dismiss()
                                    userSettings.testProgress = false
                                }
                                userSettings.openPaywall.toggle()
                            }
                        } label: {
                            HStack {
                                Image(systemName: "crown.fill")
                                    .font(.system(size: 15))
                                Text("Pro")
                                    .font(.system(size: 18))
                                    .bold()
                            }
                        }
                        .buttonStyle(BigButton(width: 72, height: 24, opacity: 0.0))
                        .scaleEffect(0.8)
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            checkNotificationStatus()
        }
    }
    // Проверяем текущий статус разрешений на уведомления
    private func checkNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                notifStatus = true
            } else {
                notifStatus = false
            }
            print("check - \(settings.authorizationStatus)")
        }
    }
    
    // Запрос разрешения на уведомления
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                notifStatus = granted
            }
        }
    }
    
    // Открыть настройки приложения, чтобы отключить уведомления
    private func openAppSettings() {
        if let appSettingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettingsURL)
        }
    }
}


#Preview {
    SettingsView()
        .environmentObject(UserSettings())
}


