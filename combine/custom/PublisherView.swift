
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import Combine

struct PublisherView: View {

    @State private var publisher: AnyCancellable?

    var body: some View {
        VStack(spacing: 10) {

            HStack(spacing: 10) {

                Button("start") {
                    self.startPublisher()
                }

                Button("Cancel") {
                    self.cancelPublisher()
                }

            }

        }
        .padding(20)
        .background(Color.white)
        .onDisappear {
            publisher?.cancel()
            publisher = nil
        }
    }

    func startPublisher() {
        self.publisher?.cancel()
        self.publisher = PublisherCustom(count: 10)
            .receive(on: DispatchQueue.main)
         // .prefix(3)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished          : print("finished")
                    case .failure(let error): print("error: \(error)")
                }
                self.publisher = nil
            }, receiveValue: { value in
                print("\(value)")
            })
    }

    func cancelPublisher() {
        self.publisher?.cancel()
    }

}
