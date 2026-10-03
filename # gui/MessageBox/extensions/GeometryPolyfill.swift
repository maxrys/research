
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
                guard newSize != self.size else {
                    return
                }
                self.size = newSize
            }
            self.content(self.size)
        }
    }

}


struct GeometryReaderInside<Content: View>: View {

    @Binding private var sizeBinding: CGSize
    @State private var size: CGSize = .zero

    private let content: (CGSize) -> Content

    init(
        size binding: Binding<CGSize> = .constant(.zero),
        @ViewBuilder content: @escaping (CGSize) -> Content
    ) {
        self._sizeBinding = binding
        self.content = content
    }

    public var body: some View {
        self.content(self.size)
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
                guard newSize != self.size else { return }
                self.size        = newSize
                self.sizeBinding = newSize
            }
    }

}

private struct GeometryChangeInsideModifier: ViewModifier {

    @Binding var size: CGSize

    func body(content: Content) -> some View {
        GeometryReaderInside(size: self.$size) { _ in
            content
        }
    }

}

extension View {

    func onGeometryChangeInside(size: Binding<CGSize>) -> some View {
        modifier(
            GeometryChangeInsideModifier(size: size)
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
            .frame(height: 300)
    }

}

struct GeometryReaderInside_Previews: PreviewProvider {

    struct ViewWithState: View {

        @State private var size1: CGSize = .zero
        @State private var size2: CGSize = .zero
        @State private var isBig: Bool = false

        var body: some View {
            HStack {
                GeometryReaderInside { size in
                    Button { self.isBig.toggle() } label: {
                        self.MarkerView()
                            .frame(width: 100, height: self.isBig ? 200 : 100)
                            .overlay (
                                Text("\(size.height)")
                                    .foregroundColor(.white)
                            )
                    }.buttonStyle(.plain)
                }
                GeometryReaderInside(size: self.$size1) { _ in
                    Button { self.isBig.toggle() } label: {
                        self.MarkerView()
                            .frame(width: 100, height: self.isBig ? 200 : 100)
                            .overlay (
                                Text("\(self.size1.height)")
                                    .foregroundColor(.white)
                            )
                    }.buttonStyle(.plain)
                }
                Button { self.isBig.toggle() } label: {
                    self.MarkerView()
                        .frame(width: 100, height: self.isBig ? 200 : 100)
                        .overlay (
                            Text("\(self.size2.height)")
                                .foregroundColor(.white)
                        )
                }
                .buttonStyle(.plain)
                .onGeometryChangeInside(size: self.$size2)
            }
        }

        @ViewBuilder private func MarkerView() -> some View {
            Rectangle()
                .fill(.blue)
        }

    }

    static var previews: some View {
        ViewWithState()
            .frame(height: 300)
    }

}
