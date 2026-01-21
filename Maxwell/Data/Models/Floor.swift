import Foundation
import SQLiteData

@Table("floors")
struct Floor: Codable, Identifiable, Sendable {
    var id: UUID
    var floorPlanId: UUID
    var name: String
    var orderIndex: Int

    init(id: UUID = UUID(), floorPlanId: UUID, name: String, orderIndex: Int) {
        self.id = id
        self.floorPlanId = floorPlanId
        self.name = name
        self.orderIndex = orderIndex
    }
}
