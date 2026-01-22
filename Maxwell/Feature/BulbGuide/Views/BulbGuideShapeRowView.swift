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
            Text(entry.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("Typical use: \(entry.typicalUse)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, BulbSpacing.xs)
    }
}
