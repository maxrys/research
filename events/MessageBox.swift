
import SwiftUI

enum MessageType {

    case info
    case ok
    case warning
    case error

    var color: Color {
        switch self {
            case .info   : .blue
            case .ok     : .green
            case .warning: .orange
            case .error  : .red
        }
    }

}

struct Message: Hashable {

    var type: MessageType
    var text: String

}

struct MessageBox: View {

    @State var messages: [Message] = []

    private let publisherInsert = EventsDispatcher.shared.publisher("messageInsert")!
    private let publisherDelete = EventsDispatcher.shared.publisher("messageDelete")!

    var body: some View {
        VStack (spacing: 1) {
            ForEach(self.messages, id: \.self) { message in
                Text(message.text)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .foregroundStyle(Color.white)
                    .background(message.type.color)
            }
        }.onReceive(self.publisherInsert) { publisher in
            if let message = publisher.object as? Message {
                self.messages.append(message)
            }
        }.onReceive(self.publisherDelete) { _ in
            self.messages = []
        }
    }

}

#Preview {
    MessageBox(messages: [
        Message(type: .info   , text: "info"),
        Message(type: .ok     , text: "ok"),
        Message(type: .warning, text: "warning"),
        Message(type: .error  , text: "error"),
    ])
    .frame(maxWidth: 200)
    .padding(10)
}
