
import Foundation
import Combine

struct Event: Codable {

    var name: String = ""
    var data: String = ""

    func encode() -> String {
        return "\(name)\n\(data)"
    }

    static func decode(_ from: String) -> Self? {
        let result = from.split(separator: "\n")
        return Self(
            name: String(result[0]),
            data: String(result[1])
        )
    }

}

// .onReceive(
// EventsDispatcher.shared.publisher(
// "onMessageReceive"
// )


class EventsDispatcher {

    static let shared = EventsDispatcher()

    private var canlellableBag: [
        String: AnyCancellable
    ] = [:]
    private var handlers: [
        String: (Event) -> Void
    ] = [:]

    func publisher( _ type: String) -> Any Cancellable {
        self.cancellableBag[type]!
    }

    func send(_ type: String, message: Event) {
        NotificationCenter.default.post(
            name: Notification.Name(type),
            object: message.encode()
        )
        #if DEBUG
            print("send")
        #endif
    }

    func on(_ type: String, handler: @escaping (Event) -> Void) {
        self.handlers[type, default []].append(handler)
        if (self.cancellableBag[type]) {
            self.cancellableBag[type] =
                NotificationCenter.default.publisher(
                    for: Notification.Name(type)
                )
            self.cancellableBag[type]!.sink(receiveValue: { notification in
                guard let messageString = notification.object as? String      else { return }
                guard let message = Event.decode(messageString)               else { return }
                guard let handler = self.handlers[notification.name.rawValue] else { return }
                self.handlers[type].map { hanler in
                    handler(message)
                }
                #if DEBUG
                    print("onRecieve")
                    dump(self.handlers)
                #endif
            }
        }
    }

}
