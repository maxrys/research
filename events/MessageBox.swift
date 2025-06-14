
import SwiftUI

struct MessageBox: View {

    static let dispatcher = EventsDispatcher.shared

    @State var messages: [String] = [
        "Message 1",
        "Message 2",
        "Message 3",
    ]

    init() {
        Self.dispatcher.on("onShowMessage") { [self] event in
            self.messages.append(
                event.data
            )
        }
    }

    var body: some View {
        VStack (spacing: 0) {
            ForEach(self.messages, id: \.self) { message in
                Text(message)
            }
        }.onReceive(EventsDispatcher.shared.publisher("onShowMessage")) { publisher in
            if let message = publisher.object as? String {
                self.messages.append(message)
            }
        }
    }

}

#Preview {
    MessageBox()
        .padding(10)
}
