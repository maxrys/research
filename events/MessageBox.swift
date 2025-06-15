
import SwiftUI

struct MessageBox: View {

    @State private var messages: [String] = []

    private let publisher = EventsDispatcher.shared.publisher(
        "onShowMessage"
    )!

    init() {
    }

    var body: some View {
        VStack (spacing: 5) {
            ForEach(self.messages, id: \.self) { message in
                Text(message)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(Color.gray)
                    .foregroundStyle(Color.white)
            }
        }.onReceive(self.publisher) { publisher in
            if let message = publisher.object as? String {
                self.messages.append(message)
            }
        }
    }

}

#Preview {
    MessageBox()
        .frame(maxWidth: 200)
        .padding(10)
}
