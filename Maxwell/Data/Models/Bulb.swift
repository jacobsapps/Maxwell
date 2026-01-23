import Foundation
import SQLiteData

@Table("bulbs")
struct Bulb: Codable, Identifiable, Sendable {
    static let defaultFittingSize = "GU10"
    static let defaultColorId = "warm-2700"

    var id: UUID
    var roomId: UUID
    var name: String
    var bulbTypeId: String
    var fittingSize: String
    var colorId: String
    var isWorking: Bool
    var markedNotWorkingAt: Date?
    var createdAt: Date

    init(
        id: UUID = UUID(),
        roomId: UUID,
        name: String,
        bulbTypeId: String,
        fittingSize: String = Bulb.defaultFittingSize,
        colorId: String = Bulb.defaultColorId,
        isWorking: Bool = true,
        markedNotWorkingAt: Date? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.roomId = roomId
        self.name = name
        self.bulbTypeId = bulbTypeId
        self.fittingSize = fittingSize
        self.colorId = colorId
        self.isWorking = isWorking
        self.markedNotWorkingAt = markedNotWorkingAt
        self.createdAt = createdAt
    }
}
