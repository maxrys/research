
import SwiftUI
import SwiftData

@main struct thisApp: App {

    @Environment(\.openWindow) private var openWindow

    var body: some Scene {
        WindowGroup {
            Button("model") {
                openWindow(id: "modelExplorer")
            }
        }

        Window("Model Explorer", id: "modelExplorer") {
            ModelExplorerView()
        }.modelContainer(ModelContainer.shared)
    }

}
