//
//  DesignSystemPreview.swift
//  Maxwell
//
//  Created by Codex on 21/01/2026.
//

import SwiftUI

struct DesignSystemPreview: View {
    private let swatches: [BulbSwatch] = [
        BulbSwatch(name: "1800K", color: .cct1800),
        BulbSwatch(name: "2700K", color: .cct2700),
        BulbSwatch(name: "3000K", color: .cct3000),
        BulbSwatch(name: "4000K", color: .cct4000),
        BulbSwatch(name: "5000K", color: .cct5000),
        BulbSwatch(name: "6500K", color: .cct6500)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: BulbSpacing.lg) {
                BulbSectionHeader("Bulb Design System", subtitle: "Warm glow, neutral clarity, cool focus")

                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.md) {
                        Text("Temperature Swatches")
                            .font(.headline)
                            .foregroundStyle(Color.bulbInk)
                        ForEach(swatches) { swatch in
                            BulbSwatchRow(swatch: swatch)
                        }
                    }
                }

                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.md) {
                        Text("Buttons")
                            .font(.headline)
                            .foregroundStyle(Color.bulbInk)
                        HStack(spacing: BulbSpacing.sm) {
                            Button("Power") {}
                                .buttonStyle(BulbPrimaryButtonStyle())
                            Button("Dim") {}
                                .buttonStyle(BulbSecondaryButtonStyle())
                        }
                        Button("Details") {}
                            .buttonStyle(BulbGhostButtonStyle())
                    }
                }

                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.md) {
                        Text("Chips")
                            .font(.headline)
                            .foregroundStyle(Color.bulbInk)
                        HStack(spacing: BulbSpacing.sm) {
                            BulbChip(title: "Warm", tone: .warm)
                            BulbChip(title: "Neutral", tone: .neutral)
                            BulbChip(title: "Cool", tone: .cool)
                        }
                    }
                }
            }
            .padding(BulbSpacing.lg)
        }
        .background(Color.bulbCanvas)
    }
}

private struct BulbSwatch: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

private struct BulbSwatchRow: View {
    let swatch: BulbSwatch

    var body: some View {
        HStack(spacing: BulbSpacing.sm) {
            swatch.color
                .frame(width: 44, height: 28)
                .clipShape(.rect(cornerRadius: BulbMetrics.smallCornerRadius))
            Text(swatch.name)
                .font(.subheadline)
                .foregroundStyle(Color.bulbInkMuted)
            Spacer()
        }
    }
}

#Preview {
    DesignSystemPreview()
}
