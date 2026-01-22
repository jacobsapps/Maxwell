//
//  BulbGuideShapeRowView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideShapeRowView: View {
    let entry: BulbShapeEntry

    var body: some View {
        VStack(alignment: .leading, spacing: BulbSpacing.xs) {
            Text(entry.code)
                .font(.headline)
                .foregroundStyle(Color.bulbInk)
            Text(entry.description)
                .font(.subheadline)
                .foregroundStyle(Color.bulbInkMuted)
            Text("Typical use: \(entry.typicalUse)")
                .font(.caption)
                .foregroundStyle(Color.bulbInkMuted)
        }
        .padding(.vertical, BulbSpacing.xs)
    }
}
