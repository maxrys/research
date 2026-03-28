
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    @State private var selectedOwner: String = ""
    @State private var selectedGroup: String = ""

    @State private var owners: [String: String] = [:]
    @State private var groups: [String: String] = [:]

    var body: some Scene {
        Window("Main", id: "main") {
            VStack(alignment: .trailing, spacing: 10) {

                HStack(spacing: 10) {
                    Text(NSLocalizedString("Owner", comment: ""))
                    Picker("", selection: self.$selectedOwner) {
                        ForEach(self.owners.ordered(), id: \.key) { key, value in
                            Text(value)
                        }
                    }
                }

                HStack(spacing: 10) {
                    Text(NSLocalizedString("Group", comment: ""))
                    Picker("", selection: self.$selectedGroup) {
                        ForEach(self.groups.ordered(), id: \.key) { key, value in
                            Text(value)
                        }
                    }
                }

            }
            .padding(20)
            .frame(width: 400)
            .onAppear {
                self.ownersReload()
                self.groupsReload()
            }
        }
    }

    private func ownersReload() {
        self.owners.removeAll()
        Process.systemUsers()
            .filter({ $0.first != "_" })
            .forEach { value in
                self.owners[value] = value
            }
    }

    private func groupsReload() {
        self.groups.removeAll()
        Process.systemGroups()
            .filter({ $0.first != "_" })
            .forEach { value in
                self.groups[value] = value
            }
    }

    init() {
    }

}
