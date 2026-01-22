//
//  BulbGuideView.swift
//  Maxwell
//
//  Created by Codex on 22/01/2026.
//

import SwiftUI

struct BulbGuideView: View {
    private let topics: [BulbGuideTopic] = [
        BulbGuideTopic(
            title: "Fittings & Bases",
            subtitle: "Match sockets, sizes, and fixture families.",
            systemImage: "bolt.circle",
            destination: .fittings
        ),
        BulbGuideTopic(
            title: "Color Temperature",
            subtitle: "Learn Kelvin ranges and how they feel.",
            systemImage: "sun.max",
            destination: .colorTemperature
        ),
        BulbGuideTopic(
            title: "Technology Types",
            subtitle: "Incandescent, LED, HID, and more.",
            systemImage: "lightbulb",
            destination: .technologyTypes
        ),
        BulbGuideTopic(
            title: "Bulb Shapes",
            subtitle: "Understand A, BR, PAR, and other forms.",
            systemImage: "circle.grid.cross",
            destination: .shapeCodes
        ),
        BulbGuideTopic(
            title: "Performance & Electrical",
            subtitle: "Lumens, CRI, wattage, and drivers.",
            systemImage: "gauge.medium",
            destination: .performance
        ),
        BulbGuideTopic(
            title: "Safety & Compliance",
            subtitle: "Ratings, certifications, and materials.",
            systemImage: "checkmark.seal",
            destination: .safety
        )
    ]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    BulbCard {
                        VStack(alignment: .leading, spacing: BulbSpacing.sm) {
                            Text("Bulb Guide")
                                .font(.headline)
                                .foregroundStyle(Color.bulbInk)
                            Text("Use this reference to compare fittings, shapes, and performance while planning your lighting.")
                                .font(.subheadline)
                                .foregroundStyle(Color.bulbInkMuted)
                        }
                    }
                    .listRowBackground(Color.bulbCanvas)
                    .listRowInsets(EdgeInsets(top: BulbSpacing.xs, leading: 0, bottom: BulbSpacing.xs, trailing: 0))
                }

                Section {
                    ForEach(topics) { topic in
                        NavigationLink(value: topic.destination) {
                            BulbGuideTopicRowView(topic: topic)
                        }
                    }
                } header: {
                    BulbSectionHeader("Guide Sections", subtitle: "Tap a topic to explore the details.")
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.bulbCanvas)
            .navigationTitle("Bulb Guide")
            .navigationDestination(for: BulbGuideDestination.self) { destination in
                switch destination {
                case .fittings:
                    BulbGuideFittingsView()
                case .colorTemperature:
                    BulbGuideColorTemperatureView()
                case .technologyTypes:
                    BulbGuideTechnologyView()
                case .shapeCodes:
                    BulbGuideShapeCodesView()
                case .performance:
                    BulbGuidePerformanceView()
                case .safety:
                    BulbGuideSafetyView()
                }
            }
        }
    }
}
