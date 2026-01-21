//
//  BulbChip.swift
//  Maxwell
//
//  Created by Codex on 21/01/2026.
//

import SwiftUI

enum BulbChipTone {
    case warm
    case neutral
    case cool

    var background: Color {
        switch self {
        case .warm:
            return .cct3000.opacity(0.25)
        case .neutral:
            return .cct4500.opacity(0.25)
        case .cool:
            return .cct6500.opacity(0.35)
        }
    }

    var foreground: Color {
        switch self {
        case .warm:
            return .bulbInk
        case .neutral:
            return .bulbInkMuted
        case .cool:
            return .bulbInk
        }
    }

    var border: Color {
        switch self {
        case .warm:
            return .cct2400.opacity(0.5)
        case .neutral:
            return .cct4000.opacity(0.5)
        case .cool:
            return .cct5500.opacity(0.5)
        }
    }
}

struct BulbChip: View {
    let title: String
    let tone: BulbChipTone

    var body: some View {
        Text(title)
            .font(.caption)
            .foregroundStyle(tone.foreground)
            .padding(.vertical, BulbSpacing.xs)
            .padding(.horizontal, BulbSpacing.sm)
            .background(tone.background, in: .rect(cornerRadius: BulbMetrics.pillRadius))
            .overlay(
                RoundedRectangle(cornerRadius: BulbMetrics.pillRadius, style: .continuous)
                    .stroke(tone.border, lineWidth: BulbMetrics.borderWidth)
            )
            .clipShape(.rect(cornerRadius: BulbMetrics.pillRadius))
    }
}
