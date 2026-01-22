//
//  BulbGuideFittingRowView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideFittingRowView: View {
    let family: BulbFittingFamily

    var body: some View {
        HStack(spacing: BulbSpacing.md) {
            BulbGuideFittingIconView(assetName: family.imageAsset)
            VStack(alignment: .leading, spacing: BulbSpacing.xs) {
                Text(family.name)
                    .font(.headline)
                    .foregroundStyle(Color.bulbInk)
                Text(family.typicalUse)
                    .font(.subheadline)
                    .foregroundStyle(Color.bulbInkMuted)
            }
        }
        .padding(.vertical, BulbSpacing.xs)
    }
}
