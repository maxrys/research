
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import AppKit
import Combine

extension NSWindow {

    static public var customWindows: [
        String: NSWindow
    ] = [:]

    static func get(_ ID: String) -> NSWindow? {
        if let window = self.customWindows[ID] { return window }
        for window in NSApplication.shared.windows {
            if let foundID = window.ID {
                if foundID == ID {
                    return window
                }
            }
        }
        return nil
    }

    static func show(_ ID: String) { Self.get(ID)?.makeKeyAndOrderFront(nil) }
    static func hide(_ ID: String) { Self.get(ID)?.orderOut(nil) }

    func show() { self.makeKeyAndOrderFront(nil) }
    func hide() { self.orderOut(nil) }

    var ID: String? {
        self.identifier?.rawValue
    }

    /* ########################################################## */

    static private var onChangeCancellableBag: [
        String: AnyCancellable
    ] = [:]

    static func onChangeRect(_ ID: String, _ action: @escaping (NSWindow) -> Void) {
        Self.onChangeCancellableBag[ID]?.cancel()
        Self.onChangeCancellableBag[ID] = NotificationCenter.default.publisher(for: Self.didResizeNotification)
            .merge(with: NotificationCenter.default.publisher(for: Self.didMoveNotification))
            .compactMap { notification in notification.object as? Self }
            .filter { window in window.ID == ID }
            .sink { window in
                Task { @MainActor in
                    action(window)
                }
            }
    }

    static func removeOnChangeRect(_ ID: String) {
        Self.onChangeCancellableBag[ID]?.cancel()
        Self.onChangeCancellableBag[ID] = nil
    }

}
