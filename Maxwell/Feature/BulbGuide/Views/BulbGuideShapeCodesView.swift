//
//  BulbGuideShapeCodesView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideShapeCodesView: View {
    private let groups: [BulbShapeGroup] = [
        BulbShapeGroup(
            title: "Classic & Decorative",
            entries: [
                BulbShapeEntry(code: "A15/A19/A21/A23", description: "Classic pear shape (A-series)", typicalUse: "Household lamps"),
                BulbShapeEntry(code: "B10/B11", description: "Candle or torpedo", typicalUse: "Chandeliers, decorative"),
                BulbShapeEntry(code: "C7/C9/C35", description: "Cone or candle", typicalUse: "Decorative, night lights"),
                BulbShapeEntry(code: "G16.5/G25/G30/G40", description: "Globe", typicalUse: "Vanity, decorative"),
                BulbShapeEntry(code: "ST19/ST64", description: "Vintage Edison style", typicalUse: "Decorative statement"),
                BulbShapeEntry(code: "S14/S11", description: "Sign and string", typicalUse: "Marquee and string lights")
            ]
        ),
        BulbShapeGroup(
            title: "Reflectors & Spot",
            entries: [
                BulbShapeEntry(code: "PAR16/PAR20/PAR30/PAR38", description: "Parabolic aluminized reflector", typicalUse: "Spot or flood, recessed"),
                BulbShapeEntry(code: "BR20/BR30/BR40", description: "Bulged reflector", typicalUse: "Recessed flood"),
                BulbShapeEntry(code: "MR11/MR16", description: "Multifaceted reflector", typicalUse: "Track and spot lighting"),
                BulbShapeEntry(code: "R20/R30/R40", description: "Rounded reflector", typicalUse: "Flood lighting"),
                BulbShapeEntry(code: "AR111", description: "Aluminum reflector", typicalUse: "Accent lighting")
            ]
        ),
        BulbShapeGroup(
            title: "Tubes & Industrial",
            entries: [
                BulbShapeEntry(code: "T5/T8/T12", description: "Tubular fluorescent or LED", typicalUse: "Office and industrial"),
                BulbShapeEntry(code: "BT15/BT28", description: "Bulged tube", typicalUse: "HID and industrial"),
                BulbShapeEntry(code: "ED17/ED18", description: "Elliptical HID", typicalUse: "Street and high-bay")
            ]
        )
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: BulbSpacing.lg) {
                GroupBox {
                    VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                        Text("Shape codes describe the bulb envelope and help ensure fit and light distribution.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                } label: {
                    Text("Shape codes")
                }

                ForEach(groups) { group in
                    GroupBox {
                        VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                            ForEach(group.entries) { entry in
                                BulbGuideShapeRowView(entry: entry)
                            }
                        }
                    } label: {
                        Text(group.title)
                    }
                }
            }
            .padding(BulbSpacing.lg)
        }
        .navigationTitle("Bulb Shapes")
    }
}
