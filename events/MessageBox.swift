
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

struct Message: Hashable, Identifiable {

    internal let id: UUID
    let title: String
    let description: String
    let type: MessageType

    init(type: MessageType, title: String, description: String = "") {
        self.id = UUID()
        self.title = title
        self.description = description
        self.type = type
    }

}

struct MessageBox: View {

    @State var messages: [Message] = []

    private let publisherInsert = EventsDispatcher.shared.publisher("messageInsert")!
    private let publisherDelete = EventsDispatcher.shared.publisher("messageDelete")!

    var body: some View {
        VStack (spacing: 1) {
            ForEach(self.messages, id: \.self) { message in
                VStack(spacing: 0) {
                    Text(message.title)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(message.type.colorTitleBackground)
                    if (!message.description.isEmpty) {
                        Text(message.description)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(message.type.colorDescriptionBackground)
                    }
                }
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
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
    ScrollView {
        MessageBox(messages: [
            Message(type: .info   , title: "Info"),
            Message(type: .ok     , title: "Ok"),
            Message(type: .warning, title: "Warning"),
            Message(type: .error  , title: "Error"),
            Message(type: .info   , title: "Info"   , description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            Message(type: .ok     , title: "Ok"     , description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            Message(type: .warning, title: "Warning", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
            Message(type: .error  , title: "Error"  , description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        ])
    }
    .frame(maxWidth: 200)
    .padding(10)
}
