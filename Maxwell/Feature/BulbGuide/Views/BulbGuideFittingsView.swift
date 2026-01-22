//
//  BulbGuideFittingsView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideFittingsView: View {
    private let families: [BulbFittingFamily] = [
        BulbFittingFamily(
            name: "Edison screw (E)",
            sizes: ["E10", "E11", "E12", "E14", "E17", "E26", "E27", "E39", "E40"],
            typicalUse: "General household & commercial",
            notes: "Threaded screw base; E26/E27 are the dominant household sizes.",
            imageAsset: "edison-screw"
        ),
        BulbFittingFamily(
            name: "Bayonet (B/BA/BAY)",
            sizes: ["B15d", "B22d", "BA15d", "BAY15d", "BA9s"],
            typicalUse: "UK/EU household, automotive",
            notes: "Push-and-twist base with side pins.",
            imageAsset: "bayonet"
        ),
        BulbFittingFamily(
            name: "Bi-pin (G)",
            sizes: ["G4", "G5", "G6.35", "G8", "G9", "G13", "G23", "G24", "2G7", "2G11"],
            typicalUse: "MR/spotlights, CFL, tubes",
            notes: "Straight pins where spacing defines size.",
            imageAsset: "bi-pin"
        ),
        BulbFittingFamily(
            name: "Twist-lock (GU/GZ)",
            sizes: ["GU10", "GU5.3", "GU4", "GU24", "GZ10"],
            typicalUse: "Recessed and spotlight fixtures",
            notes: "Short pins with a twist-lock action.",
            imageAsset: "gu10"
        ),
        BulbFittingFamily(
            name: "Loop pin (G9)",
            sizes: ["G9"],
            typicalUse: "Mini halogen and LED capsules",
            notes: "Two looped wire contacts.",
            imageAsset: "g9-loop"
        ),
        BulbFittingFamily(
            name: "Tube end (G13/G5)",
            sizes: ["G13 (T8/T12)", "G5 (T5)"],
            typicalUse: "Linear fluorescent and LED tubes",
            notes: "Rotation locks the tube into place.",
            imageAsset: "g13-tube"
        ),
        BulbFittingFamily(
            name: "Linear double-ended (R7s/RX7s)",
            sizes: ["R7s", "RX7s"],
            typicalUse: "Linear halogen and LED replacements",
            notes: "Double-ended linear lamps.",
            imageAsset: "r7s-linear"
        ),
        BulbFittingFamily(
            name: "Disc base (GX53/GX70)",
            sizes: ["GX53", "GX70"],
            typicalUse: "Low-profile puck lamps",
            notes: "Flat disc with recessed contacts.",
            imageAsset: "gx53"
        ),
        BulbFittingFamily(
            name: "Wedge (T)",
            sizes: ["T10", "T20"],
            typicalUse: "Automotive and specialty",
            notes: "Push-in wedge contact.",
            imageAsset: "wedge"
        )
    ]

    var body: some View {
        List {
            Section {
                ForEach(families) { family in
                    NavigationLink {
                        BulbGuideFittingDetailView(family: family)
                    } label: {
                        BulbGuideFittingRowView(family: family)
                    }
                }
            } header: {
                VStack(alignment: .leading) {
                    Text("Fitting Families")
                        .font(.headline)
                    Text("Match the base to your fixture.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Fittings")
    }
}
