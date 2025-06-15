
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

class EventsDispatcher {

    static let shared = EventsDispatcher()

    private var cancellableBag = Set<AnyCancellable>()
    private var publisherBag: [
        String: NotificationCenter.Publisher
    ] = [:]
    private var handlers: [
        String: [(Event) -> Void]
    ] = [:]

    func publisher( _ type: String) -> NotificationCenter.Publisher? {
        if (self.publisherBag[type] == nil) {
            self.publisherBag[type] = NotificationCenter.default.publisher(
                for: Notification.Name(type)
            )
            self.publisherBag[type]!.sink(receiveValue: { notification in
                guard let messageString = notification.object as? String else { return }
                guard let message = Event.decode(messageString)          else { return }
                guard self.handlers[notification.name.rawValue] != nil   else { return }
                for handler in self.handlers[type]! {
                    handler(message)
                }
                #if DEBUG
                    print("onRecieve")
                    dump(self.handlers)
                #endif
            }).store(in: &self.cancellableBag)
        }
        return self.publisherBag[type]!
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
        if (self.handlers[type] == nil) { self.handlers[type] = [] }
        self.handlers[type]!.append(handler)
    }

}
