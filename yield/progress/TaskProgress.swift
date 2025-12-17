
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

struct TaskProgress: AsyncSequence {

    typealias Element = Double

    let count: UInt

    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(
            count: self.count
        )
    }

}

struct AsyncIterator: AsyncIteratorProtocol {

    let count: UInt
    var i: UInt = 0

    mutating func next() async -> Double? {
        guard self.i < self.count  else { return nil }
        let progress = Double(self.i + 1) / Double(self.count)
        await self.payloadStep(
            i: self.i,
            count: self.count,
            progress: progress
        )
        self.i += 1
        return progress
    }

    func payloadStep(i: UInt, count: UInt, progress: Double) async {
        print(
            "Process (\(i) from \(count) | " +
            "\(progress.formatted(.number.precision(.fractionLength(2))))"
        )
        try? await Task.sleep(
            nanoseconds: 500_000_000
        )
    }

}
