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
                if summary.floors.isEmpty {
                    Text("No floors yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(summary.floors) { floor in
                        Section {
                            if floor.rooms.isEmpty {
                                Text("No rooms yet")
                                    .foregroundStyle(.secondary)
                            } else {
                                ForEach(floor.rooms.enumerated(), id: \.element.id) { index, room in
                                    let bulbs = summary.bulbs(for: room, in: floor)
                                    SummaryRoomRowView(
                                        roomTitle: summary.roomTitle(for: index),
                                        bulbs: bulbs,
                                        bulbTitle: summary.bulbTitle
                                    )
                                }
                            }
                        } header: {
                            BulbSectionHeader(floor.name, subtitle: summary.floorSubtitle(for: floor))
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.bulbCanvas)
            .navigationTitle("Summary")
        }
    }
}
