
import SwiftUI
import SwiftData

@main struct ThisApp: App {

    @Environment(\.openWindow) private var openWindow

    var body: some Scene {
        Window("Main", id: "main") {
            Button("model") {
                openWindow(id: "modelExplorer")
            }
        }

        Window("Model Explorer", id: "modelExplorer") {
            ModelExplorerView()
        }.modelContainer(ModelContainer.shared)
    }

}
