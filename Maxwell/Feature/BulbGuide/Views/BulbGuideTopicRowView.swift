//
//  BulbGuideTopicRowView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideTopicRowView: View {
    let topic: BulbGuideTopic

    var body: some View {
        VStack(alignment: .leading, spacing: BulbSpacing.xs) {
            Label(topic.title, systemImage: topic.systemImage)
                .font(.headline)
            Text(topic.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, BulbSpacing.xs)
    }
}
