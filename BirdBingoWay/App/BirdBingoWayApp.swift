import SwiftUI
import SwiftData

@main
struct BirdBingoWayApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.light)
        }
        .modelContainer(for: [
            SettingsModel.self
        ])
    }
}
