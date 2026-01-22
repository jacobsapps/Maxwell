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
            Tab {
                FloorPlanBuilderView(viewModel: appModel.floorPlanBuilder)
            } label: {
                Label("Floor Plan", systemImage: "square.grid.3x3")
                    .accessibilityLabel("Floor Plan Tab")
                    .accessibilityIdentifier("tab.floorPlan")
            }
            Tab {
                InteractiveFloorPlanView(viewModel: appModel.floorPlanBuilder)
            } label: {
                Label("Interactive", systemImage: "hand.draw")
                    .accessibilityLabel("Interactive Tab")
                    .accessibilityIdentifier("tab.interactive")
            }
            Tab {
                SummaryView(viewModel: appModel.floorPlanBuilder)
            } label: {
                Label("Summary", systemImage: "list.bullet.rectangle")
                    .accessibilityLabel("Summary Tab")
                    .accessibilityIdentifier("tab.summary")
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AppModel())
}
