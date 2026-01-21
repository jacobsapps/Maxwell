//
//  BulbButtonStyles.swift
//  Maxwell
//
//  Created by Codex on 21/01/2026.
//

import SwiftUI

struct BulbPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(Color.bulbInk)
            .padding(.vertical, BulbSpacing.sm)
            .padding(.horizontal, BulbSpacing.lg)
            .background(BulbGradients.warmGlow, in: .rect(cornerRadius: BulbMetrics.cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: BulbMetrics.cornerRadius, style: .continuous)
                    .stroke(Color.bulbEdge, lineWidth: BulbMetrics.borderWidth)
            )
            .clipShape(.rect(cornerRadius: BulbMetrics.cornerRadius))
            .shadow(color: Color.bulbGlow, radius: BulbMetrics.glowRadius, x: 0, y: 6)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

struct BulbSecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(Color.bulbInk)
            .padding(.vertical, BulbSpacing.sm)
            .padding(.horizontal, BulbSpacing.lg)
            .background(Color.bulbSurface, in: .rect(cornerRadius: BulbMetrics.cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: BulbMetrics.cornerRadius, style: .continuous)
                    .stroke(Color.bulbEdge, lineWidth: BulbMetrics.borderWidth)
            )
            .clipShape(.rect(cornerRadius: BulbMetrics.cornerRadius))
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

struct BulbGhostButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(Color.bulbInk)
            .padding(.vertical, BulbSpacing.xs)
            .padding(.horizontal, BulbSpacing.md)
            .background(Color.cct6500.opacity(0.12), in: .rect(cornerRadius: BulbMetrics.smallCornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: BulbMetrics.smallCornerRadius, style: .continuous)
                    .stroke(Color.cct4500.opacity(0.5), lineWidth: BulbMetrics.borderWidth)
            )
            .clipShape(.rect(cornerRadius: BulbMetrics.smallCornerRadius))
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}
