
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ScrollCustom<Content: View>: NSViewRepresentable {

    @ObservedObject var controller: ScrollController

    let content: Content
    let onScroll: (CGPoint) -> Void

    init(
        controller: ScrollController,
        @ViewBuilder content: () -> Content,
        onScroll: @escaping (CGPoint) -> Void
    ) {
        self.controller = controller
        self.content = content()
        self.onScroll = onScroll
    }

    func makeNSView(context: Context) -> NSScrollView {

        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.drawsBackground = false

        let hosting = NSHostingView(rootView: self.content)
        hosting.translatesAutoresizingMaskIntoConstraints = false

        scrollView.documentView = hosting

        NSLayoutConstraint.activate([
            hosting.leadingAnchor .constraint(equalTo: scrollView.contentView.leadingAnchor),
            hosting.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor),
            hosting.topAnchor     .constraint(equalTo: scrollView.contentView.topAnchor),
            hosting.widthAnchor   .constraint(equalTo: scrollView.contentView.widthAnchor)
        ])

        context.coordinator.observe(
            scrollView: scrollView
        )

        return scrollView
    }

    func updateNSView(_ nsView: NSScrollView, context: Context) {
        if let hosting = nsView.documentView as? NSHostingView<Content> {
            hosting.rootView = self.content
        }
    }

    func makeCoordinator() -> ScrollCoordinator {
        let coordinator = ScrollCoordinator(onScroll: self.onScroll)
        self.controller.coordinator = coordinator
        return coordinator
    }

}



final class ScrollController: ObservableObject {

    fileprivate var coordinator: ScrollCoordinator?

    func scroll(to point: CGPoint, animated: Bool = true) {
        self.coordinator?.scroll(
            to: point,
            animated: animated
        )
    }

}



class ScrollCoordinator: NSObject {

    private let onScroll: (CGPoint) -> Void
    private var programmatic = false
    private weak var scrollView: NSScrollView?

    init(onScroll: @escaping (CGPoint) -> Void) {
        self.onScroll = onScroll
    }

    func observe(scrollView: NSScrollView) {
        self.scrollView = scrollView
        scrollView.contentView.postsBoundsChangedNotifications = true
        NotificationCenter.default.addObserver(
            forName: NSView.boundsDidChangeNotification,
            object: scrollView.contentView,
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            self.onScroll(
                CGPoint(
                    x: scrollView.contentView.bounds.origin.x,
                    y: scrollView.contentView.bounds.origin.y
                )
            )
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    self.programmatic = false
                }
            }
        } else {
            sv.contentView.setBoundsOrigin(NSPoint(x: point.x, y: point.y))
            sv.reflectScrolledClipView(sv.contentView)
            DispatchQueue.main.async {
                self.programmatic = false
            }
        }
    }

}
