//
//  SummaryCountsView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 21/01/2026.
//

import SwiftUI

struct SummaryCountsView: View {
    @Bindable var viewModel: FloorPlanBuilderViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Rooms: \(viewModel.roomCount)")
            Text("Bulbs: \(viewModel.bulbCount)")
        }
        .font(.headline)
    }
}
