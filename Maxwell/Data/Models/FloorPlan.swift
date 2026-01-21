import Foundation
import SQLiteData

@Table("floor_plans")
struct FloorPlan: Codable, Identifiable, Sendable {
    var id: UUID
    var name: String

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
