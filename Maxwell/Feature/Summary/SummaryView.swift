//
//  SummaryView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct SummaryView: View {
    @Bindable var viewModel: FloorPlanBuilderViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Summary")
                    .font(.title2)
                SummaryCountsView(viewModel: viewModel)
            }
            .padding()
            .navigationTitle("Summary")
        }
    }
}
