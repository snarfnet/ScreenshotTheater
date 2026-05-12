import SwiftUI

@main
struct ScreenshotTheaterApp: App {
    @StateObject private var store = WorkStore()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(store)
        }
    }
}
