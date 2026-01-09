//
//  CurrencyViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 05/01/2026.
//

import Foundation
import Combine
import FirebaseAuth

class CurrencyViewModel: ObservableObject {
    @Published var currency: Currency
    
    private let userDefaults = UserDefaults.standard
    private let currencyKey = "local_currency"
    
    private var userService: UserService
    private var authService: AuthService
    
    init(userService : UserService = UserService(),
         authService: AuthService = AuthService()) {
        self.currency = Currency(xp: 0, gem: 0, key: 0)
        self.userService = userService
        self.authService = authService
        loadLocalCurrency()
    }

    
   func loadLocalCurrency() {
       guard let data = userDefaults.data(forKey: currencyKey),
             let currencies = try? JSONDecoder().decode(Currency.self, from: data) else {
           return
       }
       currency = currencies;
   }
    
    private func saveLocalCurrency() {
        guard let data = try? JSONEncoder().encode(currency) else {
            return
        }
        userDefaults.set(data, forKey: currencyKey)
    }
    
    
    func addCurrency(value: Int, currencyType: CurrencyType) async {
        guard let userId = authService.currentUser?.uid else {
            return
        }
        
        let shemaUser: ShemaUser
        do {
            shemaUser = try await userService.getUser(userId: userId)
        } catch {
            return
        }
        
        var newCurrency = currency
        
        switch currencyType {
        case .xp:
            newCurrency.xp += value
        case .gem:
            newCurrency.gem += value
        case .key:
            newCurrency.key += value
        }
        
        do {
            
            var updatedUser = shemaUser
            updatedUser.currency = newCurrency
            _ = try await userService.updateUser(shemaUser: updatedUser)
            await MainActor.run {
                self.currency = newCurrency
                self.saveLocalCurrency()
            }
        } catch {
            // Optionally handle the error (e.g., log or publish an error state)
        }
    }
    
    func subtractCurrecy(value: Int, currencyType: CurrencyType) async -> Bool {
        guard let userId = authService.currentUser?.uid else {
            return false
        }
        
        let shemaUser: ShemaUser
        do {
            shemaUser = try await userService.getUser(userId: userId)
        } catch {
            return false
        }
        
        
        var newCurrency = currency
        
        switch currencyType {
        case .xp:
            guard newCurrency.xp >= value else { return false }
            newCurrency.xp -= value
        case .gem:
            guard newCurrency.gem >= value else { return false }
            newCurrency.gem -= value
        case .key:
            guard newCurrency.key >= value else { return false }
            newCurrency.key -= value
        }
        
        do {
            
            var updatedUser = shemaUser
            updatedUser.currency = newCurrency
            _ = try await userService.updateUser(shemaUser: updatedUser)
            await MainActor.run {
                self.currency = newCurrency
                self.saveLocalCurrency()
            }
            return true
        } catch {
            return false
        }
    }
    
    
    func canAfford(value: Int, currencyType: CurrencyType) -> Bool {
        switch currencyType {
        case .xp:
            return currency.xp >= value
        case .gem:
            return currency.gem >= value
        case .key:
            return currency.key >= value
        }
    }
}

