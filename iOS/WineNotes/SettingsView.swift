import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var purchaseManager: PurchaseManager
    @Environment(\.dismiss) var dismiss

    private let categories = ["Reminders", "iCloud Backup (coming soon)", "Haptics"]
    @State private var toggles: [String: Bool] = ["Reminders": false, "iCloud Backup (coming soon)": false, "Haptics": true]

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    ForEach(categories, id: \.self) { category in
                        Toggle(category, isOn: Binding(
                            get: { toggles[category] ?? false },
                            set: { toggles[category] = $0 }
                        ))
                        .accessibilityIdentifier("toggle_\(category)")
                    }
                }
                Section("Pro") {
                    if purchaseManager.isPro {
                        Label("Pro unlocked", systemImage: "checkmark.seal.fill")
                            .foregroundColor(Theme.accent)
                    } else {
                        Button("Upgrade to Pro") {
                            dismiss()
                        }
                    }
                    Button("Restore Purchases") {
                        Task { await purchaseManager.restore() }
                    }
                    .accessibilityIdentifier("restoreButton")
                }
                Section("About") {
                    Link("Privacy Policy", destination: URL(string: "https://shimondeitel.github.io/winenotes-app/privacy.html")!)
                    Link("Terms of Use", destination: URL(string: "https://shimondeitel.github.io/winenotes-app/terms.html")!)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .accessibilityIdentifier("settingsDoneButton")
                }
            }
        }
    }
}
