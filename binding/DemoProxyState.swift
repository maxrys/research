

/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

/* @Observable */ class Storage<T> {
    var value: T; init(value: T) { self.value = value }
}

struct DemoProxyState: View {

    /* storage */
    var data = Storage<Double>(
        value: 1.0
    )

    /* map: storage ⇆ state */
    var zoomProxy: Binding<Double> {
        Binding<Double>(
            get: { self.data.value },
            set: { newValue in
                self.zoom = newValue
                self.data.value = newValue
                print("self.data.value: \(self.data.value)")
            }
        )
    }

    /* state */
    @State var zoom: Double = 1.0

    init() {
    }

    var body: some View {
        ZoomControll(
            zoom: self.zoomProxy
        ).onChange(of: self.zoom) { oldValue, newValue in
            print("self.zoom: \(self.data.value)")
        }
    }

}

struct ZoomControll: View {

    var zoom: Binding<Double>

    var body: some View {
        HStack {
            Text("zoom: \(String(format: "%.2f", self.zoom.wrappedValue))")
                .lineLimit(1)
                .font(.headline)
                .padding()
            Button { self.zoom.wrappedValue -= 0.1 } label: { Text("-") }
            Button { self.zoom.wrappedValue += 0.1 } label: { Text("+") }
        }
    }

}
