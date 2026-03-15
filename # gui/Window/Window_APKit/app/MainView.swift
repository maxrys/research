
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Cocoa

class MainView: NSViewController {

    private lazy var buttonHideWindow: NSButton = {
        let result = NSButton(
            title: "Hide Window with animation",
            target: self,
            action: #selector(onClickButtonHideWindow(_:))
        )
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()

    private lazy var buttonHideTitleIcons: NSButton = {
        let result = NSButton(
            title: "Hide Title Icons",
            target: self,
            action: #selector(onClickButtonHideTitleIcons(_:))
        )
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer!.backgroundColor = NSColor.windowBackgroundColor.cgColor
        view.addSubview(self.buttonHideWindow)
        view.addSubview(self.buttonHideTitleIcons)
        NSLayoutConstraint.activate([
            self.buttonHideWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.buttonHideWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc private func onClickButtonHideWindow(_ sender: NSButton) {
        NSWindow.hideWithAnimation(App.MAIN_WINDOW_ID)
    }

    @objc private func onClickButtonHideTitleIcons(_ sender: NSButton) {
        NSWindow.get(App.MAIN_WINDOW_ID)?.hideTitleButtons(isVisible: false)
    }

}
