//
//  UIImageExtension.swift
//  Crop_Image
//
//  Created by đào sơn on 06/06/2022.
//

import Foundation
import UIKit
extension UIImage {
    enum Axis {
      case horizontal, vertical
    }
  
    func flipped(_ axis: Axis) -> UIImage {
      let renderer = UIGraphicsImageRenderer(size: size)

      return renderer.image {
        let context = $0.cgContext
        context.translateBy(x: size.width / 2, y: size.height / 2)
      
        switch axis {
        case .horizontal:
          context.scaleBy(x: -1, y: 1)
        case .vertical:
          context.scaleBy(x: 1, y: -1)
        }
      
        context.translateBy(x: -size.width / 2, y: -size.height / 2)
      
        draw(at: .zero)
        }
    }
    
    //crop image to a Rect
        func cropImage(toRect: CGRect) -> UIImage? {
        let cgImage :CGImage! = self.cgImage
        let croppedCGImage: CGImage! = cgImage.cropping(to: toRect)
        return UIImage(cgImage: croppedCGImage)
    }
    
    //save image to photo library
    static func saveImage(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
    }
}

