
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

struct AsyncCounter: AsyncSequence {

    typealias Element = Int

    private var max: Int = 0

    init(_ max: Int) {
        self.max = max
    }

    func makeAsyncIterator() -> AsyncCounterIterator {
        AsyncCounterIterator(self.max)
    }

}

struct AsyncCounterIterator: AsyncIteratorProtocol {

    private var current: Int = 0
    private var max: Int = 0

    init(_ max: Int) {
        self.max = max
    }

    mutating func next() async -> Int? {
        if (self.current < self.max) {
            await self.payloadStep()
            defer { self.current += 1 }
            return self.current
        }
        return nil
    }

    func payloadStep() async {
        // Task.detached {
            try? await Task.sleep(nanoseconds: 500_000_000)
        // }
    }

}
