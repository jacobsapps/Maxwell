//
//  BulbGuideTemperatureRowView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideTemperatureRowView: View {
    let swatch: BulbTemperatureSwatch

    var body: some View {
        let toneLabel: String = {
            switch swatch.tone {
            case .warm:
                return "Warm"
            case .neutral:
                return "Neutral"
            case .cool:
                return "Cool"
            }
        }()

        HStack(spacing: BulbSpacing.md) {
            swatch.color
                .frame(width: 52, height: 36)
                .clipShape(.rect(cornerRadius: BulbMetrics.smallCornerRadius))
            VStack(alignment: .leading, spacing: BulbSpacing.xs) {
                Text("\(swatch.kelvin)K")
                    .font(.headline)
                    .foregroundStyle(Color.bulbInk)
                Text(swatch.description)
                    .font(.subheadline)
                    .foregroundStyle(Color.bulbInkMuted)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: BulbSpacing.xs) {
                BulbChip(title: toneLabel, tone: swatch.tone)
                Text(swatch.hex)
                    .font(.caption)
                    .foregroundStyle(Color.bulbInkMuted)
            }
        }
        .padding(.vertical, BulbSpacing.xs)
        .contentShape(.rect)
    }
}
