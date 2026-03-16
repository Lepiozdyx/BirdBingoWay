import SwiftUI
import SwiftData
import AVFoundation
import Observation

@Observable
final class HapticService {
    private let context: ModelContext
    private var settings: SettingsModel
    private var audioPlayer: AVAudioPlayer?
    
    init(context: ModelContext) {
        self.context = context
        
        let descriptor = FetchDescriptor<SettingsModel>()
        if let existingSettings = try? context.fetch(descriptor).first {
            self.settings = existingSettings
        } else {
            let newSettings = SettingsModel()
            context.insert(newSettings)
            try? context.save()
            self.settings = newSettings
        }
    }
    
    // MARK: - Public Methods
    
    func playSound(named soundName: String = "click") {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Sound file not found: \(soundName).mp3")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = Float(settings.volumeLevel) / 10.0
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func vibrate() {
        guard settings.isVibro else { return }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func vibrateLight() {
        guard settings.isVibro else { return }
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func vibrateHeavy() {
        guard settings.isVibro else { return }
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    func vibrateSuccess() {
        guard settings.isVibro else { return }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func vibrateError() {
        guard settings.isVibro else { return }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    func vibrateWarning() {
        guard settings.isVibro else { return }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    // MARK: - Settings Management
    
    func updateVolumeLevel(_ level: Int) {
        settings.volumeLevel = max(0, min(10, level))
        try? context.save()
    }
    
    func toggleVibro() {
        settings.isVibro.toggle()
        try? context.save()
    }
    
    func setVibro(_ enabled: Bool) {
        settings.isVibro = enabled
        try? context.save()
    }
    
    var volumeLevel: Int {
        settings.volumeLevel
    }
    
    var isVibro: Bool {
        settings.isVibro
    }
}
