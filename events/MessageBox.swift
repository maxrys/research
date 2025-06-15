
import SwiftUI

enum MessageType {

    enum ColorNames: String {
        case text                         = "color Message Text"
        case infoTitleBackground          = "color Message Info Title Background"
        case infoDescriptionBackground    = "color Message Info Description Background"
        case okTitleBackground            = "color Message Ok Title Background"
        case okDescriptionBackground      = "color Message Ok Description Background"
        case warningTitleBackground       = "color Message Warning Title Background"
        case warningDescriptionBackground = "color Message Warning Description Background"
        case errorTitleBackground         = "color Message Error Title Background"
        case errorDescriptionBackground   = "color Message Error Description Background"
    }

    case info
    case ok
    case warning
    case error

    var colorTitleBackground: Color {
        switch self {
            case .info   : Color(Self.ColorNames.infoTitleBackground.rawValue)
            case .ok     : Color(Self.ColorNames.okTitleBackground.rawValue)
            case .warning: Color(Self.ColorNames.warningTitleBackground.rawValue)
            case .error  : Color(Self.ColorNames.errorTitleBackground.rawValue)
        }
    }

    var colorDescriptionBackground: Color {
        switch self {
            case .info   : Color(Self.ColorNames.infoDescriptionBackground.rawValue)
            case .ok     : Color(Self.ColorNames.okDescriptionBackground.rawValue)
            case .warning: Color(Self.ColorNames.warningDescriptionBackground.rawValue)
            case .error  : Color(Self.ColorNames.errorDescriptionBackground.rawValue)
        }
    }

}

struct Message: Hashable {

    let title: String
    let description: String
    let type: MessageType

    init(type: MessageType, title: String, description: String = "") {
        self.title = title
        self.description = description
        self.type = type
    }

}

class ValueState<T>: ObservableObject {
    @Published var wrappedValue: T
    init(_ value: T) {
        self.wrappedValue = value
    }
}

struct MessageBox: View {

    static var MESSAGE_LIFE_TIME: Double = 1.0

    private var timerState: ValueState<RealTimer>!
    @State var messages: [UUID: Message]

    private let publisherInsert = EventsDispatcher.shared.publisher("messageInsert")!
    private let publisherDelete = EventsDispatcher.shared.publisher("messageDelete")!

    init(messages: [UUID: Message] = [:]) {
        self.messages = messages
        self.timerState = ValueState<RealTimer>(
            RealTimer(
                onTick: self.onTimerTick
            )
        )
    }

    func onTimerTick(offset: Double) {
        self.timerState?.wrappedValue.stopAndReset()
        print("tick: \(offset)")
    }

    var body: some View {
        VStack (spacing: 0) {
            ForEach(self.messages.sorted(by: { (lhs, rhs) in
                lhs.key.uuidString < rhs.key.uuidString
            }), id: \.key) { uuid, message in
                VStack(spacing: 0) {
                    Text(NSLocalizedString(message.title, comment: ""))
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(13)
                        .frame(maxWidth: .infinity)
                        .background(message.type.colorTitleBackground)
                    if (!message.description.isEmpty) {
                        Text(NSLocalizedString(message.description, comment: ""))
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(message.type.colorDescriptionBackground)
                    }
                }
                .color(Color(MessageType.ColorNames.text.rawValue))
                .frame(maxWidth: .infinity)
            }
        }.onReceive(self.publisherInsert) { publisher in
            if let message = publisher.object as? Message {
                self.messages[UUID()] = message
                self.timerState?.wrappedValue.start(
                    tickInterval: Self.MESSAGE_LIFE_TIME
                )
            }
        }.onReceive(self.publisherDelete) { _ in
            self.messages = [:]
        }
    }

    static func send(type: MessageType, title: String, description: String = "") {
        EventsDispatcher.shared.send(
            "messageInsert",
            object: Message(
                type       : type,
                title      : title,
                description: description
            )
        )
    }

    static func deleteAll() {
        EventsDispatcher.shared.send(
            "messageDelete", object: []
        )
    }

}

struct Message_Previews2: PreviewProvider {
    static var previews: some View {
        ScrollView {
            MessageBox(messages: [
                UUID(): Message(type: .info   , title: "Info"),
                UUID(): Message(type: .ok     , title: "Ok"),
                UUID(): Message(type: .warning, title: "Warning"),
                UUID(): Message(type: .error  , title: "Error"),
                UUID(): Message(type: .info   , title: "Lorem ipsum dolor sit amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                UUID(): Message(type: .ok     , title: "Lorem ipsum dolor sit amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                UUID(): Message(type: .warning, title: "Lorem ipsum dolor sit amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                UUID(): Message(type: .error  , title: "Lorem ipsum dolor sit amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            ])
        }
        .frame(maxWidth: 300)
        .padding(10)
    }
}
