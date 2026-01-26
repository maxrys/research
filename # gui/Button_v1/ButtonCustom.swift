
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ButtonCustom: View {

    enum Colors: String {
        case text                 = "color CustomButton Text"
        case textActive           = "color CustomButton Text Active"
        case border               = "color CustomButton Border"
        case background           = "color CustomButton Background"
        case backgroundFrom       = "color CustomButton Background From"
        case backgroundTo         = "color CustomButton Background To"
        case backgroundActiveFrom = "color CustomButton Background Active From"
        case backgroundActiveTo   = "color CustomButton Background Active To"
    }

    private let text: String
    private let zoom: Double
    private let isActive: Bool
    private let onClick: () -> Void

    init(text: String = "text", zoom: Double = 1.0, isActive: Bool = false, onClick: @escaping () -> Void = { }) {
        self.text = text
        self.zoom = zoom
        self.isActive = isActive
        self.onClick = onClick
    }

    var body: some View {
        Button {
            self.onClick()
        } label: {
            Text(self.text)
                .font(.system(size: 11 + (self.zoom > 1.0 ? self.zoom * 2 : 0), weight: .bold))
                .foregroundStyle(self.isActive ?
                    Color(Self.Colors.textActive.rawValue) :
                    Color(Self.Colors.text.rawValue))
                .lineLimit(1)
                .padding(.horizontal, 7 * self.zoom)
                .padding(.vertical  , 3 * self.zoom)
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color(Self.Colors.border.rawValue), lineWidth: 1)
                        .fill(
                            LinearGradient(
                                colors: self.isActive ?
                                    [Color(Self.Colors.backgroundActiveFrom.rawValue),
                                     Color(Self.Colors.backgroundActiveTo.rawValue)] :
                                    [Color(Self.Colors.backgroundFrom.rawValue),
                                     Color(Self.Colors.backgroundTo.rawValue)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                       )
                )
        }.buttonStyle(.plain)

    }

}
