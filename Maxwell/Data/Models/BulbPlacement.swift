import Foundation
import SQLiteData

@Table("bulb_placements")
struct BulbPlacement: Codable, Identifiable, Sendable {
    var id: UUID
    var bulbId: UUID
    var roomId: UUID
    var positionX: Double
    var positionY: Double
    var orientationRadians: Double
    var attachedShapeId: UUID?

    init(
        id: UUID = UUID(),
        bulbId: UUID,
        roomId: UUID,
        positionX: Double,
        positionY: Double,
        orientationRadians: Double = 0,
        attachedShapeId: UUID? = nil
    ) {
        self.id = id
        self.bulbId = bulbId
        self.roomId = roomId
        self.positionX = positionX
        self.positionY = positionY
        self.orientationRadians = orientationRadians
        self.attachedShapeId = attachedShapeId
    }
}
