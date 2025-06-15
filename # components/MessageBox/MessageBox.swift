
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

    let type: MessageType
    let title: String
    let description: String

    init(type: MessageType, title: String, description: String = "") {
        self.title = title
        self.description = description
        self.type = type
    }

}

struct MessageBox: View {

    typealias MessagesCollection = [
        UInt: (
            message: Message,
            expirationTimer: RealTimer?
        )
    ]

    private static var MESSAGE_LIFE_TIME: Double = 2.0
    private static var counter: UInt = 0

    @State var messages: MessagesCollection

    private let publisherInsert = EventsDispatcher.shared.publisher("messageInsert")!
    private let publisherDelete = EventsDispatcher.shared.publisher("messageDelete")!

    init(messages: MessagesCollection = [:]) {
        self.messages = messages
    }

    func onTimerTick(offset: Double, timer: RealTimer) {
        timer.stopAndReset()
        self.messages[timer.tag] = nil
        print("onTimerTick: \(offset) | \(timer.tag)")
    }

    var body: some View {
        VStack (spacing: 0) {
            ForEach(self.messages.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }), id: \.key) { id, item in
                VStack(spacing: 0) {
                    Text(NSLocalizedString(item.message.title, comment: ""))
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(13)
                        .frame(maxWidth: .infinity)
                        .background(item.message.type.colorTitleBackground)
                    if (!item.message.description.isEmpty) {
                        Text(NSLocalizedString(item.message.description, comment: ""))
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(item.message.type.colorDescriptionBackground)
                    }
                }
                .color(Color(MessageType.ColorNames.text.rawValue))
                .frame(maxWidth: .infinity)
            }
        }.onReceive(self.publisherInsert) { publisher in
            if let message = publisher.object as? Message {
                Self.counter += 1
                let id = Self.counter
                let expirationTimer = RealTimer(
                    tag: id,
                    onTick: self.onTimerTick
                )
                self.messages[id] = (
                    message: message,
                    expirationTimer: expirationTimer
                )
                expirationTimer.start(
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
                0: (message: Message(type: .info   , title: "Info"   ), expirationTimer: nil),
                1: (message: Message(type: .ok     , title: "Ok"     ), expirationTimer: nil),
                2: (message: Message(type: .warning, title: "Warning"), expirationTimer: nil),
                3: (message: Message(type: .error  , title: "Error"  ), expirationTimer: nil),
                4: (message: Message(type: .info   , title: "Lorem ipsum dolor sit amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."), expirationTimer: nil),
                5: (message: Message(type: .ok     , title: "Lorem ipsum dolor sit amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."), expirationTimer: nil),
                6: (message: Message(type: .warning, title: "Lorem ipsum dolor sit amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."), expirationTimer: nil),
                7: (message: Message(type: .error  , title: "Lorem ipsum dolor sit amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."), expirationTimer: nil),
            ])
        }
        .frame(maxWidth: 300)
        .padding(10)
    }
}
