
import UIKit

protocol BallProtocol {

    init(color: UIColor, radius: Int, coordinates: (x: Int, y: Int)) async

}

public class Ball: UIView, BallProtocol {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required public init(color: UIColor, radius: Int, coordinates: (x: Int, y: Int)) {
        // создание графического прямоугольника
        super.init(frame: CGRect(
            x: coordinates.x,
            y: coordinates.y,
            width : radius * 2,
            height: radius * 2
        ))
        // скругление углов
        self.layer.cornerRadius = self.bounds.width / 2.0
        // изменение цвета фона
        self.backgroundColor = color
    }

}
