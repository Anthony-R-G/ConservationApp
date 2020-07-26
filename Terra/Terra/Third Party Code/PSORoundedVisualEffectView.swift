import UIKit

class PSORoundedVisualEffectView : UIVisualEffectView{

    override func layoutSubviews() {
        super.layoutSubviews()
        updateMaskLayer()
    }

    func updateMaskLayer(){
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: Constants.cornerRadius).cgPath
        self.layer.mask = shapeLayer
    }
}
