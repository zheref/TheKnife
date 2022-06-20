import Foundation

import UIKit
import CoreMotion

class HeartButton: UIButton {

    var status: Bool = false {
        didSet {
            self.update()
        }
    }
    
    var onImage: UIImage? = {
        UIImage(named: "heart-on")?.withRenderingMode(.alwaysTemplate)
    }()
    
    var offImage: UIImage? = {
        UIImage(named: "heart-off")?.withRenderingMode(.alwaysTemplate)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setStatus(false)
        
        tintColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        UIView.transition(with: self, duration: 0.10, options: .transitionCrossDissolve, animations: { [unowned self] in
            self.status ?
                self.setImage(self.onImage, for: .normal) : self.setImage(self.offImage, for: .normal)
        }, completion: nil)
    }
    
    func toggle() {
        status ? self.setStatus(false) : self.setStatus(true)
    }
    
    func setStatus(_ status: Bool) {
        self.status = status
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        sendHapticFeedback()
        toggle()
        super.touchesEnded(touches, with: event)
    }
    
    func sendHapticFeedback() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
}
