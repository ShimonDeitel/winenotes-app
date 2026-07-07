import SwiftUI

enum Theme {
    static let accent = Color(hex: "#7A1F3D")
    static let background = Color(hex: "#160A10")
    static let card = Color(hex: "#160A10").opacity(0.6)
    static let textPrimary = Color.white.opacity(0.95)
    static let textSecondary = Color.white.opacity(0.6)

    static let titleFont = Font.custom("Didot", size: 28).weight(.bold)
    static let bodyFont = Font.custom("Didot", size: 16)
    static let labelFont = Font.custom("Didot", size: 13).weight(.medium)
}

extension Color {
    init(hex: String) {
        let h = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var int: UInt64 = 0
        Scanner(string: h).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
    }
}
