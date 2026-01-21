//
//  BulbSectionHeader.swift
//  Maxwell
//
//  Created by Codex on 21/01/2026.
//

import SwiftUI

struct BulbSectionHeader<Trailing: View>: View {
    let title: String
    let subtitle: String?
    let trailing: Trailing

    init(
        _ title: String,
        subtitle: String? = nil,
        @ViewBuilder trailing: () -> Trailing = { EmptyView() }
    ) {
        self.title = title
        self.subtitle = subtitle
        self.trailing = trailing()
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: BulbSpacing.xs) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(Color.bulbInk)
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(Color.bulbInkMuted)
                }
            }
            Spacer()
            trailing
        }
    }
}
