//
//  ContentView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 20/01/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        TabView {
            Tab("Floor Plan", systemImage: "square.grid.3x3") {
                FloorPlanBuilderView(viewModel: appModel.floorPlanBuilder)
            }
            Tab("Interactive", systemImage: "hand.draw") {
                InteractiveFloorPlanView(viewModel: appModel.floorPlanBuilder)
            }
            Tab("Summary", systemImage: "list.bullet.rectangle") {
                SummaryView(viewModel: appModel.floorPlanBuilder)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AppModel())
}
