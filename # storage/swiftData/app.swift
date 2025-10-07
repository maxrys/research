
import SwiftUI
import SwiftData

@main struct thisApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(ModelContainer.shared)
    }

}
