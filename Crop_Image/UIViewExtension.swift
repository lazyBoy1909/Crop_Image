
import Foundation
import UIKit

extension UIView {
  
  //These four methods return the positions of view elements
  //with respect to the current transformation
  
  func transformedTopLeft(resizeFrame: CGRect) -> CGPoint {
      let point = CGPoint(x: resizeFrame.minX, y: resizeFrame.minY)
      return point
  }
  
  func transformedTopRight(resizeFrame: CGRect) -> CGPoint {
      var point = CGPoint(x: resizeFrame.minX, y: resizeFrame.minY)
      point.x += resizeFrame.width
      return point
  }
  
  func transformedBottomRight(resizeFrame: CGRect) -> CGPoint {
      var point = CGPoint(x: resizeFrame.minX, y: resizeFrame.minY)
      point.x += resizeFrame.size.width
      point.y += resizeFrame.size.height
      return point
  }
  
  func transformedBottomLeft(resizeFrame: CGRect) -> CGPoint {
      var point = CGPoint(x: resizeFrame.minX, y: resizeFrame.minY)
      point.y += resizeFrame.size.height
      return point
  }
  func setAnchorPoint(anchorPoint:CGPoint) {
      var newPoint = CGPoint(x: self.bounds.size.width * anchorPoint.x, y: self.bounds.size.height * anchorPoint.y)
      var oldPoint = CGPoint(x: self.bounds.size.width * self.layer.anchorPoint.x, y: self.bounds.size.height * self.layer.anchorPoint.y)
      newPoint = newPoint.applying(self.transform)
      oldPoint = oldPoint.applying(self.transform)
    
      var position = self.layer.position
      position.x -= oldPoint.x
      position.x += newPoint.x
      position.y -= oldPoint.y
      position.y += newPoint.y
    
      self.layer.position = position
      self.layer.anchorPoint = anchorPoint
  }

}

