//
//  BulbGuideSpecRowView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideSpecRowView: View {
    let item: BulbSpecItem

    var body: some View {
        VStack(alignment: .leading, spacing: BulbSpacing.xs) {
            Text(item.title)
                .font(.headline)
            Text(item.detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let notes = item.notes {
                Text(notes)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, BulbSpacing.xs)
    }
}
