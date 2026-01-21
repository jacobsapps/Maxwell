//
//  BulbColors.swift
//  Maxwell
//
//  Created by Codex on 21/01/2026.
//

import SwiftUI

extension Color {
    init(hex: UInt32, alpha: Double = 1) {
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    // CCT swatches (from context/spec/light-bulb-types.md)
    static let cct1800 = Color(hex: 0xFF7E00)
    static let cct2200 = Color(hex: 0xFF9227)
    static let cct2400 = Color(hex: 0xFF9B3D)
    static let cct2700 = Color(hex: 0xFFA757)
    static let cct3000 = Color(hex: 0xFFB16E)
    static let cct3500 = Color(hex: 0xFFC18D)
    static let cct4000 = Color(hex: 0xFFCEA6)
    static let cct4500 = Color(hex: 0xFFDABB)
    static let cct5000 = Color(hex: 0xFFE4CE)
    static let cct5500 = Color(hex: 0xFFEDDE)
    static let cct6500 = Color(hex: 0xFFFEFA)
    static let cct7500 = Color(hex: 0xE6EBFF)

    // Semantic accents
    static let bulbWarm = cct2700
    static let bulbNeutral = cct4000
    static let bulbCool = cct6500

    // Surfaces and ink
    static let bulbCanvas = cct6500.opacity(0.12)
    static let bulbSurface = cct3500.opacity(0.18)
    static let bulbEdge = cct2400.opacity(0.45)
    static let bulbGlow = cct2200.opacity(0.4)
    static let bulbInk = Color(hex: 0x1F1A16)
    static let bulbInkMuted = Color(hex: 0x3A2C22)
}
