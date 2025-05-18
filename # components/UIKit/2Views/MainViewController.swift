
import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var labelResult: UILabel!

    lazy var aboutView: AboutViewController = {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "about")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onClick_buttonStart() {
    }

    @IBAction func onClick_buttonAbout() {
        self.present(self.aboutView, animated: true, completion: {})
    }

}
