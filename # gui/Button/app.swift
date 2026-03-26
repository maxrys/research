
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

@main struct ThisApp: App {

    public var body: some Scene {
        WindowGroup {
            VStack(spacing: 20) {

                VStack {
                    Text("flexibility").font(.headline)
                    ButtonCustom()
                    ButtonCustom(flexibility: .none)
                    ButtonCustom(flexibility: .size(100))
                    ButtonCustom(flexibility: .infinity)
                }

                HStack(spacing: 0) {
                    VStack {
                        Text("light style").font(.headline)
                        ButtonCustom(colorStyle: .accent)
                        ButtonCustom(colorStyle: .danger)
                        ButtonCustom(colorStyle: .custom(text: nil, background: nil))
                        ButtonCustom(colorStyle: .custom(text: .white, background: .orange))
                    }
                    .padding(20)
                    .environment(\.colorScheme, .light)
                    .background(Color.white)

                    VStack {
                        Text("dark style").font(.headline)
                        ButtonCustom(colorStyle: .accent)
                        ButtonCustom(colorStyle: .danger)
                        ButtonCustom(colorStyle: .custom(text: nil, background: nil))
                        ButtonCustom(colorStyle: .custom(text: .white, background: .orange))
                    }
                    .padding(20)
                    .environment(\.colorScheme, .dark)
                    .background(Color.getNS(\.darkGray))
                }

            }
            .frame(width: 210)
            .padding(20)
        }
    }

    init() {
    }

}
