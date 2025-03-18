
import SwiftUI

@main struct app: App {
    var body: some Scene {
        WindowGroup {

            HStack {

                Canvas { context, size in
                    context.drawRectangle()
                }
                .frame(width: 200, height: 200)
                .background(.gray)

                Canvas { context, size in
                    context.drawRectangle(
                        x: 0,
                        y: 0,
                        w: 200,
                        h: 200,
                        radius: 20,
                        lineWidth: 5,
                        colorLine: Color(.black),
                        colorFill: Color(.blue)
                    )
                }
                .frame(width: 200, height: 200)
                .background(.gray)

            }

            HStack {

                Canvas { context, size in
                    context.drawRectangleGradient()
                }
                .frame(width: 200, height: 200)
                .background(.gray)

                Canvas { context, size in
                    context.drawRectangleGradient(
                        x: 0,
                        y: 0,
                        w: 200,
                        h: 200,
                        radius: 20,
                        lineWidth: 5,
                        colorLine    : Color(.black),
                        colorFillFrom: Color(.blue),
                        colorFillTo  : Color(.green),
                        gradientFrom : CGPoint(x: 0, y: 0),
                        gradientTo   : CGPoint(x: 0, y: 200)
                    )
                }
                .frame(width: 200, height: 200)
                .background(.gray)

            }

        }
    }

    init() {
    }

}
