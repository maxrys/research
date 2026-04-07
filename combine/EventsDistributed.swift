
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation
import Combine

class EventsDistributed {

    @MainActor static let shared = EventsDistributed()

    private var cancellableBag = Set<AnyCancellable>()
    private var publisherBag: [
        String: NotificationCenter.Publisher
    ] = [:]
    private var handlers: [
        String: [(String) -> Void]
    ] = [:]

    public func publisher( _ type: String) -> NotificationCenter.Publisher? {
        if (self.publisherBag[type] == nil) {
            self.publisherBag[type] = DistributedNotificationCenter.default.publisher(for: Notification.Name(type))
            self.publisherBag[type]!.sink(receiveValue: { notification in
                guard let event = notification.object as? String else { return }
                for handler in self.handlers[type] ?? [] {
                    handler(event)
                }
            }).store(in: &self.cancellableBag)
        }
        return self.publisherBag[type]!
    }

    public func send(_ type: String, object: String) {
        DistributedNotificationCenter.default().postNotificationName(
            Notification.Name(type),
            object: object,
            deliverImmediately: true
        )
    }

    public func on(_ type: String, handler: @escaping (String) -> Void) {
        if (self.handlers[type] == nil) { self.handlers[type] = [] }
        self.handlers[type]!.append(handler)
    }

}
