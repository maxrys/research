
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

struct ColorHSB: Equatable, Codable {

    var hue: Double
    var saturation: Double
    var brightness: Double
    var opacity: Double

    init(_ hue: Double, _ saturation: Double, _ brightness: Double, _ opacity: Double = 1.0) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.opacity = opacity
    }

    init?(decode json: String) {
        do {
            guard let data = json.data(using: .utf8) else {
                return nil
            }
            self = try JSONDecoder().decode(
                Self.self,
                from: data
            )
        } catch {
            return nil
        }
    }

    func encode() -> String? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return String(
            data: data,
            encoding: .utf8
        )
    }

}
