
import SwiftUI

struct MessageBox: View {

    static let dispatcher = EventsDispatcher.shared

    @State var messages: [String] = [
    ]

    init() {
         Self.dispatcher.on("onShowMessage") { [self] event in
             // self.messages.append(
             //     event.data
             // )
         }
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
        }.onReceive(EventsDispatcher.shared.publisher("onShowMessage")!) { publisher in
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
