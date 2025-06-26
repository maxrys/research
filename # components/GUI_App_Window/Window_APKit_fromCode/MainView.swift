
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Cocoa

class MainView: NSViewController {

    private lazy var button: NSButton = {
        let result = NSButton(
            title: "Push me",
            target: self,
            action: #selector(onButtonClicked(_:))
        )
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer!.backgroundColor = NSColor.windowBackgroundColor.cgColor
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc private func onButtonClicked(_ sender: NSButton) {
        print("OK")
    }

}
