
import UIKit

class ResizableView: UIView {

    var topLeft:DragHandle!
    var topRight:DragHandle!
    var bottomLeft:DragHandle!
    var bottomRight:DragHandle!

    override func didMoveToSuperview() {
        topLeft = DragHandle()
        topRight = DragHandle()
        bottomLeft = DragHandle()
        bottomRight = DragHandle()
        superview?.addSubview(topLeft)
        superview?.addSubview(topRight)
        superview?.addSubview(bottomLeft)
        superview?.addSubview(bottomRight)
      
        var pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        topLeft.addGestureRecognizer(pan)
        pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        topRight.addGestureRecognizer(pan)
        pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        bottomLeft.addGestureRecognizer(pan)
        pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        bottomRight.addGestureRecognizer(pan)
        pan = UIPanGestureRecognizer(target: self, action: #selector(handleMove))
        self.addGestureRecognizer(pan)
        self.updateDragHandles()
      }

    func updateDragHandles() {
        topLeft.center = self.transformedTopLeft(resizeFrame: self.frame)
        topRight.center = self.transformedTopRight(resizeFrame: self.frame)
        bottomLeft.center = self.transformedBottomLeft(resizeFrame: self.frame)
        bottomRight.center = self.transformedBottomRight(resizeFrame: self.frame)
    }

  //MARK: - Gesture Methods
    @objc func handleMove(gesture:UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview!)
        var center = self.center
        center.x += translation.x
        center.y += translation.y
        self.center = center
        gesture.setTranslation(CGPoint.zero, in: self.superview!)
        updateDragHandles()
    }
    
    @objc func handlePan(gesture:UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        switch gesture.view! {
        case topLeft:
            if gesture.state == .began
            {
                self.setAnchorPoint(anchorPoint: CGPoint(x: 1, y: 1))
            }
            self.bounds.size.width -= translation.x
            self.bounds.size.height -= translation.y
        case topRight:
            if gesture.state == .began
            {
                self.setAnchorPoint(anchorPoint: CGPoint(x: 0, y: 1))
            }
            self.bounds.size.width += translation.x
            self.bounds.size.height -= translation.y
        case bottomLeft:
            if gesture.state == .began
            {
                self.setAnchorPoint(anchorPoint: CGPoint(x: 1, y: 0))
            }
            self.bounds.size.width -= translation.x
            self.bounds.size.height += translation.y
        case bottomRight:
            if gesture.state == .began
            {
                self.setAnchorPoint(anchorPoint: CGPoint.zero)
            }
            self.bounds.size.width += translation.x
            self.bounds.size.height += translation.y
        default:()
    }
    
        gesture.setTranslation(CGPoint.zero, in: self)
        updateDragHandles()
        if gesture.state == .ended
        {
            self.setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 0.5))
        }
  }
}

