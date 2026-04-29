
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct FileIteratorView: View {

    static public let DEMO_PATH = "/Volumes/dev/xcode/# research/iterator/file/demo.txt"
    static public let MESSAGE_STATUS_SUCCESS_LOCALIZED        = NSLocalizedString("success", comment: "")
    static public let MESSAGE_STATUS_FAILURE_LOCALIZED        = NSLocalizedString("failure", comment: "")
    static public let MESSAGE_STATUS_TASK_CANCELLED_LOCALIZED = NSLocalizedString("Task was cancelled.", comment: "")

    @State private var task: Task<Void, Never>? = nil
    @State private var progress: Double = 0.0
    @State private var report: [(column1: String, column2: String)] = []

    var body: some View {
        VStack(spacing: 10) {

            HStack(spacing: 10) {

                Button("Reading") {
                    self.onClickStart()
                }.disabled(self.task != nil)

                Button("Reading Async") {
                    self.onClickStart()
                }.disabled(self.task != nil)

                Button("Cancel") {
                    self.onClickCancel()
                }.disabled(self.task == nil)

            }

            ProgressCustom(
                value: self.progress
            )

            Text("Progress: \(Int(self.progress * 100)) %")

            ScrollView {
                let columns = [
                    GridItem(.flexible(), spacing: 0, alignment: .leading),
                    GridItem(.fixed(200), spacing: 0, alignment: .center),
                ]
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach (self.report.indices.reversed(), id: \.self) { index in
                        let reportInfo = self.report[index]
                        Text(reportInfo.column1).id(Double(index) + 0.1)
                        Text(reportInfo.column2).id(Double(index) + 0.2)
                    }
                }
            }

        }
        .padding(20)
        .background(Color.white)
        .onDisappear {
            self.onClickCancel()
        }
    }

    private func onClickStart() {
        if let fileSequence = FileSequence(path: Self.DEMO_PATH, chunkSize: nil) {
            self.task = Task {
                self.progress = 0.0
                self.report = []
                process: for result in fileSequence {
                    self.progress = result.progress
                    switch result.status {
                        case .failure(_, let text): self.report.append((column1: "error: \(text)"                                           , column2: Self.MESSAGE_STATUS_FAILURE_LOCALIZED))
                        case .success             : self.report.append((column1: "offset = \(result.offset) | progress = \(result.progress)", column2: Self.MESSAGE_STATUS_SUCCESS_LOCALIZED))
                        case .cancelledByUser     : self.report.append((column1: ""                                                         , column2: Self.MESSAGE_STATUS_TASK_CANCELLED_LOCALIZED)); break process
                    }
                    try? await Task.sleep(
                        nanoseconds: 10_000_000
                    )
                }
                self.task = nil
            }
        }
    }

    private func onClickStartAsync() {
        if let fileSequence = FileSequenceAsync(path: Self.DEMO_PATH, chunkSize: nil) {
            self.task = Task {
                self.progress = 0.0
                self.report = []
                process: for await result in fileSequence {
                    self.progress = result.progress
                    switch result.status {
                        case .failure(_, let text): self.report.append((column1: "error: \(text)"                                           , column2: Self.MESSAGE_STATUS_FAILURE_LOCALIZED))
                        case .success             : self.report.append((column1: "offset = \(result.offset) | progress = \(result.progress)", column2: Self.MESSAGE_STATUS_SUCCESS_LOCALIZED))
                        case .cancelledByUser     : self.report.append((column1: ""                                                         , column2: Self.MESSAGE_STATUS_TASK_CANCELLED_LOCALIZED)); break process
                    }
                    try? await Task.sleep(
                        nanoseconds: 10_000_000
                    )
                }
                self.task = nil
            }
        }
    }

    private func onClickCancel() {
        if let task = self.task {
            task.cancel()
            self.task = nil
        }
    }

}
