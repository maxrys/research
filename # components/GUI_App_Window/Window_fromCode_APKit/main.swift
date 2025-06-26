
import Cocoa

let app = NSApplication.shared
app.setActivationPolicy(.regular)
let delegate = ThisApp()
app.delegate = delegate
app.run()
