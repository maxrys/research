
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

private struct GeometrySizePreferenceKey: PreferenceKey {

    static let defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }

}

struct GeometryReaderOutside<Content: View>: View {

    @State private var size: CGSize = .zero

    private let axes: Axis.Set
    private let alignment: Alignment
    private let content: (CGSize) -> Content

    init(
        axes: Axis.Set,
        alignment: Alignment = .center,
        @ViewBuilder content: @escaping (CGSize) -> Content,
    ) {
        self.axes = axes
        self.alignment = alignment
        self.content = content
    }

    public var body: some View {
        ZStack(alignment: self.alignment) {
            Group {
                if      (axes.contains([.horizontal, .vertical])) { Color.clear }
                else if (axes.contains([.horizontal           ])) { Color.clear.frame(height: 0) }
                else if (axes.contains([             .vertical])) { Color.clear.frame(width: 0) }
            }.overlay (
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: GeometrySizePreferenceKey.self,
                            value: geometry.size
                        )
                }
            )
            .onPreferenceChange(GeometrySizePreferenceKey.self) { newSize in
                size = newSize
            }
            self.content(self.size)
        }
    }

}


struct GeometryReaderPolyfill<Content: View>: View {

    @Binding private var size: CGSize

    private let content: () -> Content

    init(
        size: Binding<CGSize>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._size = size
        self.content = content
    }

    public var body: some View {
        self.content()
            .overlay (
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: GeometrySizePreferenceKey.self,
                            value: geometry.size
                        )
                }
            )
            .onPreferenceChange(GeometrySizePreferenceKey.self) { newSize in
                Task { @MainActor in
                    guard newSize != size else {
                        return
                    }
                    size = newSize
                }
            }
    }

}

private struct GeometryChangePolyfillModifier: ViewModifier {

    @Binding var size: CGSize

    func body(content: Content) -> some View {
        GeometryReaderPolyfill(size: self.$size) {
            content
        }
    }

}

extension View {

    func onGeometryChangePolyfill(size: Binding<CGSize>) -> some View {
        modifier(
            GeometryChangePolyfillModifier(size: size)
        )
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct GeometryReaderOutside_Previews: PreviewProvider {

    struct ViewWithState: View {

        @State private var isBig: Bool = false

        var body: some View {
            GeometryReaderOutside(axes: .vertical) { size in
                Button { self.isBig.toggle() } label: {
                    self.MarkerView()
                        .frame(width: 100, height: self.isBig ? 200 : 100)
                        .overlay (
                            Text("\(size.height)")
                                .foregroundColor(.white)
                        )
                }.buttonStyle(.plain)
            }
        }

        @ViewBuilder private func MarkerView() -> some View {
            Rectangle()
                .fill(.blue)
        }

    }

    static var previews: some View {
        ViewWithState()
            .frame(width: 100, height: 300)
    }

}

struct GeometryReaderPolyfill_Previews: PreviewProvider {

    struct ViewWithState: View {

        @State private var currentSize: CGSize = .zero
        @State private var isBig: Bool = false

        var body: some View {
            GeometryReaderPolyfill(size: self.$currentSize) {
                Button { self.isBig.toggle() } label: {
                    self.MarkerView()
                        .frame(width: 100, height: self.isBig ? 200 : 100)
                        .overlay (
                            Text("\(self.currentSize.height)")
                                .foregroundColor(.white)
                        )
                }.buttonStyle(.plain)
            }
        }

        @ViewBuilder private func MarkerView() -> some View {
            Rectangle()
                .fill(.blue)
        }

    }

    static var previews: some View {
        ViewWithState()
            .frame(width: 100, height: 300)
    }

}

struct onGeometryChangePolyfill_Previews: PreviewProvider {

    struct ViewWithState: View {

        @State private var currentSize: CGSize = .zero
        @State private var isBig: Bool = false

        var body: some View {
            Button { self.isBig.toggle() } label: {
                self.MarkerView()
                    .frame(width: 100, height: self.isBig ? 200 : 100)
                    .overlay (
                        Text("\(self.currentSize.height)")
                            .foregroundColor(.white)
                    )
            }
            .buttonStyle(.plain)
            .onGeometryChangePolyfill(size: self.$currentSize)
        }

        @ViewBuilder private func MarkerView() -> some View {
            Rectangle()
                .fill(.blue)
        }

    }

    static var previews: some View {
        ViewWithState()
            .frame(width: 100, height: 300)
    }

}
