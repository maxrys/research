
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation
import Combine

enum PublisherCustomError: Error {
    case demandValue
}

struct PublisherCustom: Publisher {

    typealias Output = Int
    typealias Failure = PublisherCustomError

    let count: Int

    init(count: Int) {
        self.count = count
    }

    func receive<S>(subscriber: S) where S: Subscriber, PublisherCustomError == S.Failure, Int == S.Input {
        let subscription = SubscriptionCustom(subscriber: subscriber, count: count)
        subscriber.receive(subscription: subscription)
    }

}

private final class SubscriptionCustom<S: Subscriber>: Subscription where S.Input == Int, S.Failure == PublisherCustomError {

    private var subscriber: S?
    private let count: Int

    init(subscriber: S, count: Int) {
        self.subscriber = subscriber
        self.count = count
    }

    func request(_ demand: Subscribers.Demand) {
        guard let subscriber = self.subscriber else { return }
        guard demand == .unlimited else {
            subscriber.receive(completion: .failure(.demandValue))
            return
        }
        for i in 0 ..< self.count {
            _ = subscriber.receive(i)
        }
        subscriber.receive(
            completion: .finished
        )
    }

    func cancel() {
        self.subscriber = nil
    }

}
