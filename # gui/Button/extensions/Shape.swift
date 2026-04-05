
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Shape {

    @ViewBuilder func fillGradientPolyfill(_ color: Color) -> some View {
        if #available(macOS 13.0, *) {
            self.fill(
                color.gradient
            )
        } else {
            self.fill(
                LinearGradient(
                    colors: [color.opacity(0.7), color],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }

//  @ViewBuilder func fillGradientPolyfill(_ color: Color) -> some View {
//      if #available(macOS 13.0, *) {
//          self.fill(color.gradient)
//      } else {
//          VStack(spacing: 0) {
//              Color.white.overlayPolyfill { LinearGradient(colors: [ color.opacity(0.8), color.opacity(1.0) ], startPoint: .top, endPoint: .bottom) }
//              Color.black.overlayPolyfill { LinearGradient(colors: [ color.opacity(1.0), color.opacity(0.9) ], startPoint: .top, endPoint: .bottom) }
//          }
//      }
//  }

}
