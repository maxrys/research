
import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        VStack(spacing: 10) {
            Button("+") {
                let newItem = Item(timestamp: Date())
                modelContext.insert(newItem)
            }
            ScrollView {
                ForEach(items) { item in
                    HStack {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        Button("X") {
                            modelContext.delete(item)
                        }
                    }
                }
            }
        }.padding(10)
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
