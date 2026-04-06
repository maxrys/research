
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import os
import SwiftUI
import ZIPFoundation

@main struct ThisApp: App {

    var body: some Scene {
        WindowGroup {
            VStack(spacing: 10) {

                Button("compress file") {
                    compressFile(
                        from: "/Users/max/Desktop/test/file.txt",
                        to: "/Users/max/Desktop/test/compressFile.zip")
                }

            }
        }
    }

    init() {
    }

    func compressFile(from sourcePath: String, to destinationPath: String) {
        do {
            let archiveURL = URL(fileURLWithPath: destinationPath)
            let archive = try Archive(
                url: archiveURL,
                accessMode: .create
            )
            let sourceURL = URL(fileURLWithPath: sourcePath)
            try archive.addEntry(
                with: sourceURL.lastPathComponent,
                fileURL: sourceURL
            )
        } catch {
            Logger.customLog("\(error.localizedDescription)")
        }
    }

}
