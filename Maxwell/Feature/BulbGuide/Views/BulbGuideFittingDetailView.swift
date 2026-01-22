//
//  BulbGuideFittingDetailView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideFittingDetailView: View {
    let family: BulbFittingFamily

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: BulbSpacing.lg) {
                BulbCard {
                    HStack(spacing: BulbSpacing.md) {
                        BulbGuideFittingIconView(assetName: family.imageAsset, size: 64)
                        VStack(alignment: .leading, spacing: BulbSpacing.xs) {
                            Text(family.name)
                                .font(.title3)
                                .bold()
                                .foregroundStyle(Color.bulbInk)
                            Text(family.typicalUse)
                                .font(.subheadline)
                                .foregroundStyle(Color.bulbInkMuted)
                        }
                        Spacer()
                    }
                }

                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        BulbSectionHeader("Common sizes")
                        ScrollView(.horizontal) {
                            HStack(spacing: BulbSpacing.sm) {
                                ForEach(family.sizes, id: \.self) { size in
                                    BulbChip(title: size, tone: .neutral)
                                }
                            }
                            .padding(.vertical, BulbSpacing.xs)
                        }
                        .scrollIndicators(.hidden)
                    }
                }

                BulbCard {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        BulbSectionHeader("Notes")
                        Text(family.notes)
                            .font(.subheadline)
                            .foregroundStyle(Color.bulbInkMuted)
                    }
                }
            }
            .padding(BulbSpacing.lg)
        }
        .background(Color.bulbCanvas)
        .navigationTitle(family.name)
    }
}
