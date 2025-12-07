
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    var body: some Scene {
        WindowGroup {
            Main()
        }
    }

}

struct Main: View {

    @State private var isShowingPopover = false

    var body: some View {
        Button("Show Popover") {
            self.isShowingPopover = true
        }
        .popover(isPresented: self.$isShowingPopover, arrowEdge: .bottom) {
            Popover(isShowingPopover: self.$isShowingPopover)
        }
    }

}

struct Popover: View {

    @Binding private var isShowingPopover: Bool
    @State var isShowingDialog = false

    init(isShowingPopover: Binding<Bool>) {
        self._isShowingPopover = isShowingPopover
    }

    var body: some View {
        Button("Show dialog") {
            self.isShowingDialog = true
        }
        .padding(20)
        .confirmationDialog("What to do?", isPresented: self.$isShowingDialog) {
            Button("Close Dialog", role: .cancel) {
                self.isShowingDialog = false
            }
            Button("Close Dialog + Popover", role: .destructive) {
                self.isShowingDialog = false
                self.isShowingPopover = false
            }
        }
    }

}
