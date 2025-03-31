
import UIKit

class ViewController : UIViewController {

    override func loadView() {
        // размеры прямоугольной области
        let sizeOfArea = CGSize(
            width : UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height
        )
        // создание экземпляра
        let area = SquareArea(
            size: sizeOfArea,
            color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        )

        area.setBalls(
            withColors: [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)],
            andRadius: 20
        )

        // установка экземпляра в качестве текущего отображения
        let rootView = UIView()
        rootView.backgroundColor = .white
        rootView.addSubview(area)
        self.view = rootView
    }

}
