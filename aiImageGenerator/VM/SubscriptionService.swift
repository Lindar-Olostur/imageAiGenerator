//
//  SubscriptionService.swift
//  aiImageGenerator
//
//  Created by Lindar Olostur on 12.09.2024.
//

import Foundation
import ApphudSDK
import SwiftUI

enum Product: String {
    case y3 = "yearly_39.99_trial3"
    case y = "yearly_39.99_notrial"
    case m3 = "monthly_19.99_trial3"
    case m = "monthly_19.99_notrial"
}

final class SubscriptionService: ObservableObject {
    @Published var hasSubs: Bool
    @Published var activeSubscription: Bool = false
    @Published var availableProducts: [ApphudProduct] = []
    
    //@Published var choosenProduct = Product.m3.rawValue
    
    static let shared = SubscriptionService()
    
    private init() {
        hasSubs = Apphud.hasActiveSubscription()
    }
    
    // Получение доступных подписок
    @MainActor
    func fetchSubscriptions() async {
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            Apphud.fetchPlacements { placements, error in
                // if placements are already loaded, callback will be invoked immediately
                if let placement = placements.first(where: { $0.identifier == "your_placement_id" }), let paywall = placement.paywall {
                    let fetchedProducts = paywall.products
                    
                    // Обновляем переменную products с результатом
                    self.availableProducts = fetchedProducts
                    
                    // Завершаем выполнение async функции
                    continuation.resume()
                } else {
                    // Если что-то пошло не так, завершить функцию
                    continuation.resume()
                }
            }
        }
    }
    
    
    // Оформление подписки
 //   @MainActor
    func purchase(productId: String) async {
        print("Attempting to purchase product with ID: \(productId)")
        do {
            let product = availableProducts.first { $0.productId == productId }
            guard let selectedProduct = product else {
                print("Product with ID \(productId) not found.")
                return
            }
            
            let result = await Apphud.purchase(selectedProduct)
            if let subscription = result.subscription, subscription.isActive() {
                print("Active subscription purchased successfully: \(subscription)")
                self.activeSubscription = true
            } else if let purchase = result.nonRenewingPurchase, purchase.isActive() {
                print("Active non-renewing purchase: \(purchase)")
                self.activeSubscription = true
            }
        }
    }
    
    // Восстановление покупок
    
    func restorePurchases() async {
        await Apphud.restorePurchases()
    }
    func optionalBinding(_ binding: Binding<Picture>) -> Binding<Picture?> {
            return Binding<Picture?>(
                get: { binding.wrappedValue }, // Вернуть значение Picture как опциональное
                set: { newValue in
                    if let newValue = newValue {
                        binding.wrappedValue = newValue // Если есть новое значение, обновляем
                    }
                }
            )
        }
}
