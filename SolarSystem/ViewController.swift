import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak private var containerSaturnView: UIView!
    @IBOutlet weak private var containerEarthView: UIView!
    @IBOutlet weak private var containerJupiterView: UIView!
    
    @IBOutlet weak private var constantTopPlanetEarth: NSLayoutConstraint!
    @IBOutlet weak private var constantTopPlanetJupiter: NSLayoutConstraint!
    @IBOutlet weak private var constantTopPlanetSaturn: NSLayoutConstraint!
    var duration : TimeInterval = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [ (view: containerEarthView,
           constant: constantTopPlanetEarth),
          (view: containerJupiterView,
           constant: constantTopPlanetJupiter),
          (view: containerSaturnView,
           constant: constantTopPlanetSaturn)
        ].forEach {
            $0.constant?.constant = -containerEarthView.bounds.size.height / 2
            $0.view?.animationPlanet(duration: duration)
            duration += 1
        }
    }
}

extension UIView {
    func animationPlanet(duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear) {
            self.transform = CGAffineTransform.identity
            self.transform = CGAffineTransform(rotationAngle: -CGFloat.pi * 0.99)
        } completion: { (bool) in
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear) {
                self.transform = CGAffineTransform(rotationAngle: -CGFloat.pi * 0.99 * 2)
            } completion: { [self] (bool) in
                animationPlanet(duration: duration)
            }
        }
    }
}
