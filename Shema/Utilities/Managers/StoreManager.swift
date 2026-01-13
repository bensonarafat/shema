//
//  StoreManager.swift
//  Shema
//
//  Created by Benson Arafat on 12/01/2026.
//

import StoreKit
import Combine

class StoreManager: NSObject, ObservableObject, SKPaymentTransactionObserver, SKProductsRequestDelegate, SKRequestDelegate {
    @Published var products: [SKProduct] = []
    @Published var purchasedProducts: Set<String> = []
    
    private let productIDs: Set<String> =
    ["com.pulsereality.shema.premium.weekly", "com.pulsereality.shema.premium.monthly", "com.pulsereality.shema.premium.yearly"]
    
    override init () {
        super.init()
        SKPaymentQueue.default().add(self)
        fetchProducts()
    }
    
    // MARK: - SKPaymentTransactionObserver
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                handlePurchased(transaction)
            case .restored:
                handleRestored(transaction)
            case .failed:
                handleFailed(transaction)
            case .purchasing, .deferred:
                break
            @unknown default:
                break
            }
        }
    }
    
    
    private func handlePurchased(_ transaction: SKPaymentTransaction) {
        purchasedProducts.insert(transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func handleRestored(_ transaction: SKPaymentTransaction) {
        if let productId = transaction.original?.payment.productIdentifier {
            purchasedProducts.insert(productId)
        }
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func handleFailed(_ transaction: SKPaymentTransaction) {
        if let error = transaction.error as? SKError {
            print("Transaction failed: \(error.localizedDescription)")
        }
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: productIDs)
        request.delegate = self
        request.start()
    }
    
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    // MARK: - SKProductsRequestDelegate
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let fetched = response.products
        DispatchQueue.main.async {
            self.products = fetched
        }
    }

    // MARK: - SKRequestDelegate
    func request(_ request: SKRequest, didFailWithError error: Error) {
        // You may want to surface this via a published error or logging
        print("SKRequest failed with error: \(error.localizedDescription)")
    }

    func requestDidFinish(_ request: SKRequest) {
        // Optional: handle completion if needed
    }
}
