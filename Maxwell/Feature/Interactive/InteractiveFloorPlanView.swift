//
//  InteractiveFloorPlanView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct InteractiveFloorPlanView: View {
    @Bindable var viewModel: FloorPlanBuilderViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Text("Interactive Floor Plan")
                    .font(.title2)
                Text("This view will render the live plan.")
                    .foregroundStyle(.secondary)
                SummaryCountsView(viewModel: viewModel)
            }
            .padding()
            .navigationTitle("Interactive")
        }
    }
}
