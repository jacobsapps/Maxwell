//
//  BulbGuideTechnologyRowView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideTechnologyRowView: View {
    let technology: BulbTechnologyType

    var body: some View {
        VStack(alignment: .leading, spacing: BulbSpacing.xs) {
            Text(technology.name)
                .font(.headline)
            Text(technology.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("Typical uses: \(technology.typicalUses)")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(technology.notes)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
