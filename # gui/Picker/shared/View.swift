
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

enum KeyEquivalentPolyfill: String {
    case upArrow    = "\u{F700}"
    case downArrow  = "\u{F701}"
    case leftArrow  = "\u{F702}"
    case rightArrow = "\u{F703}"
    case `return`   = "\n"
}

extension View {

    @ViewBuilder func foregroundPolyfill(_ color: Color) -> some View {
        if #available(macOS 14.0, iOS 17.0, *) { self.foregroundStyle(color) }
        else                                   { self.foregroundColor(color) }
    }

    @ViewBuilder func contentShapePolyfill<S: Shape>(_ shape: S = Capsule()) -> some View {
        if #available(macOS 12.0, *) { self.contentShape(.focusEffect, shape) }
        else                         { self }
    }

    @ViewBuilder func scrollDisabledPolyfill(_ disabled: Bool) -> some View {
        if #available(macOS 13.0, *) { self.scrollDisabled(disabled) }
        else                         { self }
    }

    @ViewBuilder func onKeyPressPolyfill(character: String, action: @escaping () -> Void) -> some View {
        if #available(macOS 14.0, *) {
            self.onKeyPress(phases: .down) { press in
                if (press.characters.contains(character)) { action() }
                return .ignored
            }
        } else { self }
    }

    @ViewBuilder func flexibility(_ value: Flexibility = .none) -> some View {
        switch value {
            case .size(let size): self.frame(width: size)
            case .infinity      : self.frame(maxWidth: .infinity)
            case .none          : self
        }
    }

    @ViewBuilder func onHoverCursor(isEnabled: Bool = true) -> some View {
        self.onHover { isInView in
            if (isEnabled) {
                if (isInView) { NSCursor.pointingHand.push() }
                else          { NSCursor.pop() }
            }   else          { NSCursor.pop() }
        }
    }

}
