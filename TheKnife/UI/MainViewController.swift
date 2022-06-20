import UIKit

class MainController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
    }
    
    private func customizeView() {
        navigationBar.prefersLargeTitles = true
    }

}
