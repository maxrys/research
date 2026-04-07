
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State private var task: Task<Void, Never>? = nil

    var body: some Scene {
        WindowGroup {
            HStack {
                Button("doSome") { Task { await onClickDoSome() } }
                Button("cancel") { Task { await onClickCancel() } }
            }
        }
    }

    func onClickDoSome() async {
        self.task = Task {
            for i in 1...10 {
                if Task.isCancelled { print("Task cancelled at: \(i)"); return }
                try? await Task.sleep(nanoseconds: 500_000_000)
                print("Iteration: \(i)")
            }
            print("Task completed")
        }
    }

    func onClickCancel() async {
        if let task = self.task {
            task.cancel()
        }
    }

}
