
import Foundation

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

class EventsDispatcher {

    static let shared = EventsDispatcher()

    let center: DistributedNotificationCenter = .default()

    var handlers: [
        String: (_ message: Event) -> Void
    ] = [:]

    func send(_ type: String, message: Event) {
        self.center.postNotificationName(
            NSNotification.Name(type),
            object: message.encode(),
            userInfo: nil,
            deliverImmediately: true
        )
        #if DEBUG
            print("send")
        #endif
    }

    func on(_ type: String, handler: @escaping (Event) -> Void) {
        self.handlers[type] = handler
        self.center.addObserver(
            self,
            selector: #selector(onRecieve(_:)),
            name: NSNotification.Name(type),
            object: nil
        )
        #if DEBUG
            dump(self.handlers)
        #endif
    }

    @objc private func onRecieve(_ notification: NSNotification) {
        guard let messageString = notification.object as? String      else { return }
        guard let message = Event.decode(messageString)               else { return }
        guard let handler = self.handlers[notification.name.rawValue] else { return }
        handler(message)
        #if DEBUG
            print("onRecieve")
        #endif
    }

}
