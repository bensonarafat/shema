//
//  PricingView.swift
//  Shema
//
//  Created by Benson Arafat on 28/03/2026.
//

import SwiftUI
import StoreKit

struct PricingView: View {
    @StateObject private var store = StoreKitManager()
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var router: AppRouter
     
    @State private var selectedProductID: String? = nil
    @State private var isPurchasing: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 8) {
                    Text("Grow deeper,\nevery single day.")
                        .font(.appDisplay)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text("Unlock full access to your daily devotion experience.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                // Features
                VStack(alignment: .leading, spacing: 14) {
                    PricingFeatureRow(icon: "book.fill",        text: "Daily Bible devotions & readings")
                    PricingFeatureRow(icon: "lock.shield.fill", text: "App lock until devotion is complete")
                    PricingFeatureRow(icon: "bell.badge.fill",  text: "Personalised daily reminders")
                    PricingFeatureRow(icon: "chart.bar.fill",   text: "Streak tracking & accountability")
                    PricingFeatureRow(icon: "heart.fill",       text: "Focus areas tailored to your needs")
                }
                .padding(.horizontal)
                
                Divider().padding(.horizontal)
                
                // Plans
                VStack(spacing: 12) {
                    // Free tier
                    FreePlanCard(
                        isSelected: selectedProductID == "free",
                        onSelect: { selectedProductID = "free" }
                    )
                    
                    if store.isLoading {
                        ProgressView()
                            .padding()
                    } else {
                        ForEach(store.products, id: \.id) { product in
                            PlanCard(
                                product: product,
                                isSelected: selectedProductID == product.id,
                                isPurchased: store.isPurchased(product),
                                onSelect: { selectedProductID = product.id }
                            )
                        }
                    }
                }
                .padding(.horizontal)
                
                // CTA Button
                Button {
                    Task { await handleContinue() }
                } label: {
                    Group {
                        if isPurchasing {
                            ProgressView().tint(.white)
                        } else {
                            Text(selectedProductID == "free" || selectedProductID == nil
                                 ? "Continue with Free"
                                 : "Get Started")
                        }
                    }
                    .font(.appButtonPrimary)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.primaryColorFeatherGreen)
                    )
                }
                .disabled(isPurchasing)
                .padding(.horizontal)
                
                // Restore
                Button("Restore purchases") {
                    Task { await store.restorePurchases() }
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                
                // Legal
                Text("Subscriptions auto-renew unless cancelled 24 hours before the renewal date.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 32)
            }
        }
        .navigationBarBackButtonHidden()
        .alert("Something went wrong", isPresented: .constant(store.errorMessage != nil)) {
            Button("OK") { store.errorMessage = nil }
        } message: {
            Text(store.errorMessage ?? "")
        }
    }
    
    private func handleContinue() async {
        guard let id = selectedProductID else {
            // Nothing selected — default to free
            authManager.appState = .main
            return
        }
        
        if id == "free" {
            authManager.appState = .main
            return
        }
        
        guard let product = store.products.first(where: { $0.id == id }) else { return }
        
        isPurchasing = true
        let success = await store.purchase(product)
        isPurchasing = false
        
        if success {
            authManager.appState = .main
        }
    }
}

#Preview {
    PricingView()
        .environmentObject(AuthManager())
        .environmentObject(AppRouter())
}


struct FreePlanCard: View {
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Free")
                        .fontWeight(.semibold)
                    Text("Basic daily reading, limited features")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.primaryColorFeatherGreen)
                        .font(.title3)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.gray.opacity(0.07))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(isSelected ? Color.primaryColorFeatherGreen : Color.gray.opacity(0.2), lineWidth: 1.5)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

struct PlanCard: View {
    let product: Product
    let isSelected: Bool
    let isPurchased: Bool
    let onSelect: () -> Void
    
    private var isYearly: Bool { product.id.contains("yearly") }
    private var isLifetime: Bool { product.id.contains("lifetime") }
    
    private var badge: String? {
        if isYearly { return "Best Value" }
        if isLifetime { return "One-time" }
        return nil
    }
    
    private var description: String {
        if isLifetime { return "Pay once, access forever" }
        if isYearly {
            if let months = product.subscription?.subscriptionPeriod {
                return "\(product.displayPrice) / year • save ~40%"
            }
            return "\(product.displayPrice) / year"
        }
        return "\(product.displayPrice) / month"
    }
    
    var body: some View {
        Button(action: onSelect) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(product.displayName)
                            .fontWeight(.semibold)
                        
                        if let badge {
                            Text(badge)
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(
                                    Capsule()
                                        .fill(Color.primaryColorFeatherGreen)
                                )
                        }
                    }
                    
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if isPurchased {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.primaryColorFeatherGreen)
                        .font(.title3)
                } else if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.primaryColorFeatherGreen)
                        .font(.title3)
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.gray.opacity(0.4))
                        .font(.title3)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.gray.opacity(0.07))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(isSelected ? Color.primaryColorFeatherGreen : Color.gray.opacity(0.2), lineWidth: 1.5)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

struct PricingFeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.primaryColorFeatherGreen)
                .frame(width: 24)
            Text(text)
                .font(.subheadline)
        }
    }
}
