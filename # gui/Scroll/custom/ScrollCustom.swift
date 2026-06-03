
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ScrollCustom<Content: View>: NSViewRepresentable {

    @ObservedObject private var controller: ScrollController

    private let content: Content
    private let onScroll: (CGPoint) -> Void

    init(
        controller: ScrollController,
        @ViewBuilder content: () -> Content,
        onScroll: @escaping (CGPoint) -> Void
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

    public func scroll(to point: CGPoint, animated: Bool = true) {
        self.coordinator?.scroll(
            to: point,
            animated: animated
        )
    }

}



class ScrollCoordinator: NSObject {

    private let onScroll: (CGPoint) -> Void
    private weak var scrollView: NSScrollView?
    private var programmatic = false
    private var position: CGPoint? = nil
    private var time: CFTimeInterval? = nil

    init(onScroll: @escaping (CGPoint) -> Void) {
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
            self.position = scrollView.contentView.bounds.origin
            self.time = CACurrentMediaTime()
            self.onScroll(scrollView.contentView.bounds.origin)
        }
    }

    public func scroll(to point: CGPoint, animated: Bool = true) {
        guard let sv = self.scrollView else { return }
        programmatic = true
        if (animated) {
            NSAnimationContext.runAnimationGroup { ctx in
                ctx.duration = 0.25
                sv.contentView.animator().setBoundsOrigin(NSPoint(x: point.x, y: point.y))
                sv.reflectScrolledClipView(sv.contentView)
            } completionHandler: {
                Task {
                    try? await Task.sleep(nanoseconds: 50_000_000)
                    self.programmatic = false
                }
            }
        } else {
            sv.contentView.setBoundsOrigin(NSPoint(x: point.x, y: point.y))
            sv.reflectScrolledClipView(sv.contentView)
            Task { @MainActor in
                self.programmatic = false
            }
        }
    }

    private func getSpeed(point1: CGPoint, point2: CGPoint, time1: TimeInterval, time2: TimeInterval) -> Double {
        let dt = max(1e-6, time2 - time1)
        let dx = Double(point2.x - point1.x)
        let dy = Double(point2.y - point1.y)
        let vx = dx / dt
        let vy = dy / dt
        return hypot(vx, vy)
    }

}
