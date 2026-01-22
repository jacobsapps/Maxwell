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
                    .accessibilityIdentifier("tab.floorPlan")
            }
            Tab {
                SummaryView(viewModel: appModel.floorPlanBuilder)
            } label: {
                Label("Summary", systemImage: "list.bullet.rectangle")
                    .accessibilityIdentifier("tab.summary")
            }
            Tab {
                BulbGuideView()
            } label: {
                Label("Bulb Guide", systemImage: "lightbulb")
                    .accessibilityIdentifier("tab.guide")
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AppModel())
}
