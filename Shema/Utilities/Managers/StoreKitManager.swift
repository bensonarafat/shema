//
//  StoreManager.swift
//  Shema
//
//  Created by Benson Arafat on 12/01/2026.
//

import StoreKit
import Combine
import Foundation

class StoreKitManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var purchasedProductIDs: Set<String> = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let productIDs: Set<String> = [
        "com.pulsereality.shema.premium.weekly",
        "com.pulsereality.shema.premium.monthly",
        "com.pulsereality.shema.premium.yearly",
    ]
    
    private var transactionListener: Task<Void, Error>?
    
    init () {
        transactionListener = listenForTransactions()
        Task { await loadProducts() }
        Task { await restorePurchases() }
    }
    
    deinit {
        transactionListener?.cancel()
    }
    
    func loadProducts() async {
        isLoading = true
        do {
            products = try await Product.products(for: productIDs)
                .sorted { $0.price < $1.price }
        } catch {
            errorMessage = "Failed to load plans"
        }
        isLoading = false
    }
    
    func purchase(_ product: Product) async -> Bool {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                await updatePurchasedProducts()
                await transaction.finish()
                return true
            case .userCancelled:
                return false
            case .pending:
                return false
            @unknown default:
                return false
            }
        } catch {
            errorMessage = "Purchase failed. Please try again."
            return false
        }
    }
    
    func restorePurchases() async {
        do {
            try await AppStore.sync()
            await updatePurchasedProducts()
        } catch {
            errorMessage = "Restore failed"
        }
    }
    
    var hasActiveSubscription: Bool {
        !purchasedProductIDs.isEmpty
    }
    
    func isPurchased(_ product: Product) -> Bool {
        purchasedProductIDs.contains(product.id)
    }
    
    private func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            if let transaction = try? checkVerified(result) {
                purchasedProductIDs.insert(transaction.productID)
            }
        }
    }
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .verified(let value): return value
        case .unverified: throw StoreError.failedVerification
        }
    }
    
    private func listenForTransactions() -> Task<Void, Error> {
        Task.detached {
            for await result in Transaction.updates {
                if  let transaction = try? await self.checkVerified(result) {
                    await self.updatePurchasedProducts()
                    await transaction.finish()
                }
            }
        }
    }
}

enum StoreError: Error {
    case failedVerification
}
