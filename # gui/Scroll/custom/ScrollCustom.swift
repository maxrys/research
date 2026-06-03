
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ScrollCustom<Content: View>: NSViewRepresentable {

    @ObservedObject private var controller: ScrollController

    private let content: Content
    private let onScroll: (CGPoint, Double) -> Void

    init(
        controller: ScrollController,
        @ViewBuilder content: () -> Content,
        onScroll: @escaping (CGPoint, Double) -> Void
    ) {
        self.controller = controller
        self.content = content()
        self.onScroll = onScroll
    }

    internal func makeNSView(context: Context) -> NSScrollView {

        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.drawsBackground = false

        let hosting = NSHostingView(rootView: self.content)
        hosting.translatesAutoresizingMaskIntoConstraints = false

        scrollView.documentView = hosting

        context.coordinator.observe(
            scrollView: scrollView
        )

        return scrollView
    }

    internal func updateNSView(_ nsView: NSScrollView, context: Context) {
        if let hosting = nsView.documentView as? NSHostingView<Content> {
            hosting.rootView = self.content
        }
    }

    internal func makeCoordinator() -> ScrollCoordinator {
        let coordinator = ScrollCoordinator(onScroll: self.onScroll)
        self.controller.coordinator = coordinator
        return coordinator
    }

}



final class ScrollController: ObservableObject {

    fileprivate var coordinator: ScrollCoordinator?

    public func scroll(to position: CGPoint, animated: Bool = true) {
        self.coordinator?.scroll(
            to: position,
            animated: animated
        )
    }

}



class ScrollCoordinator: NSObject {

    private let onScroll: (CGPoint, Double) -> Void
    private weak var scrollView: NSScrollView?
    private var programmatic = false
    private var position: CGPoint? = nil
    private var time: CFTimeInterval? = nil

    init(onScroll: @escaping (CGPoint, Double) -> Void) {
        self.onScroll = onScroll
    }

    fileprivate func observe(scrollView: NSScrollView) {
        self.scrollView = scrollView
        scrollView.contentView.postsBoundsChangedNotifications = true
        NotificationCenter.default.addObserver(
            forName: NSView.boundsDidChangeNotification,
            object: scrollView.contentView,
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            let newPosition = scrollView.contentView.bounds.origin
            let newTime = CACurrentMediaTime()
            let speed = self.getSpeed(
                position1: self.position,
                position2: newPosition,
                time1: self.time,
                time2: newTime)
            self.position = newPosition
            self.time     = newTime
            self.onScroll(newPosition, speed)
        }
    }

    public func scroll(to position: CGPoint, animated: Bool = true) {
        guard let sv = self.scrollView else { return }
        programmatic = true
        if (animated) {
            NSAnimationContext.runAnimationGroup { ctx in
                ctx.duration = 0.25
                sv.contentView.animator().setBoundsOrigin(NSPoint(x: position.x, y: position.y))
                sv.reflectScrolledClipView(sv.contentView)
            } completionHandler: {
                Task {
                    try? await Task.sleep(nanoseconds: 50_000_000)
                    self.programmatic = false
                }
            }
        } else {
            sv.contentView.setBoundsOrigin(NSPoint(x: position.x, y: position.y))
            sv.reflectScrolledClipView(sv.contentView)
            Task { @MainActor in
                self.programmatic = false
            }
        }
    }

    private func getSpeed(position1: CGPoint?, position2: CGPoint?, time1: TimeInterval?, time2: TimeInterval?) -> Double {
        guard let position1 else { return 0 }
        guard let position2 else { return 0 }
        guard let time1     else { return 0 }
        guard let time2     else { return 0 }
        let dt = max(1e-6, time2 - time1)
        let dx = Double(position2.x - position1.x)
        let dy = Double(position2.y - position1.y)
        let vx = dx / dt
        let vy = dy / dt
        return hypot(vx, vy)
    }

}
