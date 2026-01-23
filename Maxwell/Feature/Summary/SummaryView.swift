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
        let summary = SummaryViewModel(floors: viewModel.floors)
        NavigationStack {
            List {
                ForEach(summary.floors) { floor in
                    Section {
                        if floor.rooms.isEmpty {
                            Text("No rooms yet")
                                .foregroundStyle(.secondary)
                        } else {
                            ForEach(floor.rooms.enumerated(), id: \.element.id) { index, room in
                                let bulbs = summary.bulbs(for: room, in: floor)
                                SummaryRoomRowView(
                                    roomTitle: summary.roomTitle(for: room, index: index),
                                    bulbs: bulbs,
                                    bulbTitle: summary.bulbTitle
                                )
                            }
                        }
                    } header: {
                        VStack(alignment: .leading) {
                            Text(floor.name)
                                .font(.headline)
                            Text(summary.floorSubtitle(for: floor))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .overlay {
                if summary.floors.isEmpty {
                    ContentUnavailableView(
                        "No floors yet",
                        systemImage: "square.grid.3x3",
                        description: Text("Add a floor to start building your plan.")
                    )
                }
            }
            .navigationTitle("Summary")
        }
    }
}
