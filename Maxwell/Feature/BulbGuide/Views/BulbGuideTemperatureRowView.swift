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
                Text(swatch.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: BulbSpacing.xs) {
                Text(toneLabel)
                    .font(.caption)
                    .padding(.horizontal, BulbSpacing.sm)
                    .padding(.vertical, BulbSpacing.xs)
                    .background(.thinMaterial, in: .capsule)
                Text(swatch.hex)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, BulbSpacing.xs)
    }
}
