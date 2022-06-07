//
//  PHAssetExtension.swift
//  Crop_Image
//
//  Created by đào sơn on 06/06/2022.
//

import Foundation
import Photos
import UIKit
extension PHAsset
{
    static func loadRandomPHAssetImageFromGallery() ->PHAsset?
    {
        var assetImages: [PHAsset] = []
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects{
        (object,_,_) in
            assetImages.append(object)
        }
        return assetImages.randomElement()
    }
    
    func fetchImage(widthSize: Double, heightSize: Double, contentMode: PHImageContentMode) ->UIImage
    {
        let manager = PHImageManager.default()
        var resultImage: UIImage!
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        manager.requestImage(for:  self, targetSize: CGSize(width: widthSize,height: heightSize), contentMode: contentMode, options: option, resultHandler: { (result, info)-> Void in
            if let image = result
            {
                resultImage = image
            }
            else
            {
                print("Failed to get image from asset")
                resultImage = UIImage(systemName: "exclamationmark.icloud.fill")!;
            }
        })
        return resultImage
    }
}
