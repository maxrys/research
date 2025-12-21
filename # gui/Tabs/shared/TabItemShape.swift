
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct TabItemShape: Shape {

    public var radius: CGFloat = 5

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + self.radius))
        path.addArc(center: CGPoint(x: rect.minX + self.radius, y: rect.minY + self.radius), radius: self.radius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX - self.radius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - self.radius, y: rect.minY + self.radius), radius: self.radius, startAngle: .degrees(270), endAngle: .degrees(360), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }

}
