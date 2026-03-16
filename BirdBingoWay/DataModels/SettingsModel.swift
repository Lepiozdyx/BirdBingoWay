import SwiftData

@Model
final class SettingsModel {
    var volumeLevel: Int
    var isVibro: Bool
    
    init() {
        volumeLevel = 10
        isVibro = true
    }
}
