//
//  ContentView.swift
//  Maxwell
//
//  Created by Jacob Bartlett on 20/01/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppModel.self) private var appModel
    @State private var selectedTab: AppTab = .floorPlan

    init() {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains(DebugArguments.seedSummary) {
            _selectedTab = State(initialValue: .summary)
        }
        #endif
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(value: AppTab.floorPlan) {
                FloorPlanBuilderView(viewModel: appModel.floorPlanBuilder)
            } label: {
                Label("Floor Plan", systemImage: "square.grid.3x3")
                    .accessibilityIdentifier("tab.floorPlan")
            }
            Tab(value: AppTab.summary) {
                SummaryView(viewModel: appModel.floorPlanBuilder)
            } label: {
                Label("Summary", systemImage: "list.bullet.rectangle")
                    .accessibilityIdentifier("tab.summary")
            }
            Tab(value: AppTab.guide) {
                BulbGuideView()
            } label: {
                Label("Bulb Guide", systemImage: "lightbulb")
                    .accessibilityIdentifier("tab.guide")
            }
        }
        .onAppear {
            #if DEBUG
            if ProcessInfo.processInfo.arguments.contains(DebugArguments.seedSummary) {
                selectedTab = .summary
            }
            #endif
        }
    }
}

private enum AppTab: Hashable {
    case floorPlan
    case summary
    case guide
}

#Preview {
    ContentView()
        .environment(AppModel())
}
