//
//  BulbGradients.swift
//  Maxwell
//
//  Created by Codex on 21/01/2026.
//

import SwiftUI

enum BulbGradients {
    static let warmGlow = RadialGradient(
        colors: [
            .cct3000.opacity(0.9),
            .cct2400.opacity(0.7),
            .cct1800.opacity(0.4),
            .cct1800.opacity(0.15)
        ],
        center: .center,
        startRadius: 0,
        endRadius: 140
    )

    static let neutralGlow = RadialGradient(
        colors: [
            .cct4500.opacity(0.85),
            .cct4000.opacity(0.6),
            .cct3500.opacity(0.35),
            .cct3000.opacity(0.15)
        ],
        center: .center,
        startRadius: 0,
        endRadius: 140
    )

    static let coolGlow = RadialGradient(
        colors: [
            .cct6500.opacity(0.9),
            .cct5500.opacity(0.6),
            .cct5000.opacity(0.35),
            .cct4500.opacity(0.18)
        ],
        center: .center,
        startRadius: 0,
        endRadius: 150
    )

    static let glassSheen = LinearGradient(
        colors: [
            .cct6500.opacity(0.6),
            .cct5500.opacity(0.25),
            .cct5000.opacity(0.1),
            .cct4500.opacity(0.2)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
