
import Foundation
import SwiftData

extension ModelContainer {

    static var shared: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

}

@Model final class Item {

    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }

}
