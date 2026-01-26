
import SwiftUI
import SwiftData

struct ModelExplorerView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var items: [ModelItem]

    var body: some View {
        VStack(spacing: 10) {
            Button("+") {
                let newItem = ModelItem(timestamp: Date())
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
    ModelExplorerView()
        .frame(width: 300)
        .modelContainer(
            for: ModelItem.self,
            inMemory: true
        )
}
