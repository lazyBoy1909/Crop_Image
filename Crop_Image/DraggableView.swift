
let diameter:CGFloat = 40

import UIKit

protocol DraggableViewDelegate: AnyObject
{
    func draggableView(_ view: DraggableView, didPan gesture: UIPanGestureRecognizer)
}

class DraggableView: UIView {
    weak var delegate: DraggableViewDelegate?
    private var pan: UIPanGestureRecognizer!
    var fillColor = UIColor.white
    var strokeColor = UIColor(red: 0, green: 0.5, blue: 1.0, alpha: 1.0)
    var strokeWidth:CGFloat = 2.0
    required init(coder aDecoder: NSCoder) {
        fatalError("Use init(fillColor:, strokeColor:)")
    }
  
    init(strokeWidth width:CGFloat = 2.0) {
        super.init(frame:CGRect(x: 0, y: 0, width: diameter, height: diameter))
        self.strokeWidth = width
        self.backgroundColor = UIColor.clear
        addPanGesture()
    }
    
    func addPanGesture()
    {
        pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        self.addGestureRecognizer(pan)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let handlePath = UIBezierPath(ovalIn: rect.insetBy(dx:  10 + strokeWidth, dy:  10 + strokeWidth))
        fillColor.setFill()
        handlePath.fill()
        strokeColor.setStroke()
        handlePath.lineWidth = strokeWidth
        handlePath.stroke()
    }
    
    @objc func handlePan()
    {
        delegate?.draggableView(self, didPan: pan)
    }
}
