
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import AVFoundation

struct Progress: View {

    private var value: Double
    private var onChange: (Double) -> Void

    init(value: Double = 0.5, onChange: @escaping (Double) -> Void = { _ in }) {
        self.value    = value
        self.onChange = onChange
    }

    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .leading) {
                let widthByValue = reader.size.width * (value).fixBounds(max: 1)
                Color(.gray).frame(width: reader.size.width, height: reader.size.height)
                Color(.blue).frame(width: widthByValue     , height: reader.size.height)
            }.onTapGesture { coords in
                self.onChange(
                    (coords.x / reader.size.width).fixBounds(max: 1)
                )
            }
        }
    }

}
