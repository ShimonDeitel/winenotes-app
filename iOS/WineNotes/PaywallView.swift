import SwiftUI

struct PaywallView: View {
    @EnvironmentObject var purchaseManager: PurchaseManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            VStack(spacing: 24) {
                Spacer()
                Image(systemName: "sparkles")
                    .font(.system(size: 56))
                    .foregroundColor(Theme.accent)
                Text("Wine Notes Pro")
                    .font(Theme.titleFont)
                    .foregroundColor(Theme.textPrimary)
                Text("Region stats, price-vs-rating chart")
                    .font(Theme.bodyFont)
                    .foregroundColor(Theme.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                if let product = purchaseManager.product {
                    Button {
                        Task { await purchaseManager.purchase() }
                    } label: {
                        Text("Unlock for \(product.displayPrice) / one-time purchase")
                            .font(Theme.bodyFont.weight(.bold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Theme.accent)
                            .cornerRadius(14)
                    }
                    .accessibilityIdentifier("purchaseButton")
                    .padding(.horizontal, 32)
                } else {
                    ProgressView()
                }

                Button("Restore Purchases") {
                    Task { await purchaseManager.restore() }
                }
                .accessibilityIdentifier("restorePurchasesButton")
                .foregroundColor(Theme.textSecondary)

                Spacer()
                Button("Not now") { dismiss() }
                    .accessibilityIdentifier("dismissPaywallButton")
                    .foregroundColor(Theme.textSecondary)
                    .padding(.bottom, 24)
            }
        }
    }
}
