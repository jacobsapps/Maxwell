//
//  BulbGuideFittingsView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideFittingsView: View {
    private let families = BulbFittingFamily.catalog

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
