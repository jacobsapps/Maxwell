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
                GroupBox {
                    HStack(spacing: BulbSpacing.md) {
                        BulbGuideFittingIconView(assetName: family.imageAsset, size: 64)
                        VStack(alignment: .leading, spacing: BulbSpacing.xs) {
                            Text(family.name)
                                .font(.title3)
                                .bold()
                            Text(family.typicalUse)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        ScrollView(.horizontal) {
                            HStack(spacing: BulbSpacing.sm) {
                                ForEach(family.sizes, id: \.self) { size in
                                    Text(size)
                                        .font(.caption)
                                        .padding(.horizontal, BulbSpacing.sm)
                                        .padding(.vertical, BulbSpacing.xs)
                                        .background(.thinMaterial, in: .capsule)
                                }
                            }
                            .padding(.vertical, BulbSpacing.xs)
                        }
                        .scrollIndicators(.hidden)
                    }
                } label: {
                    Text("Common sizes")
                }

                GroupBox {
                    Text(family.notes)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                } label: {
                    Text("Notes")
                }
            }
            .padding(BulbSpacing.lg)
        }
        .navigationTitle(family.name)
    }
}
