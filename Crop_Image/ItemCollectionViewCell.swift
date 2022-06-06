//
//  ItemCollectionViewCell.swift
//  Crop_Image
//
//  Created by đào sơn on 06/06/2022.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var itemImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initCell(cellImage image: UIImage?)
    {
        if image != nil
        {
            self.itemImageView.image = image
        }
    }
}
