//
//  ViewController.swift
//  Crop_Image
//
//  Created by đào sơn on 06/06/2022.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet private weak var itemCollectionView: UICollectionView!
    @IBOutlet private weak var cropImageView: UIImageView!
    var itemImage: [UIImage?] = [UIImage(named: "ic_rotate1"), UIImage(named: "ic_rotate2"),
                                 UIImage(systemName: "flip.horizontal"), UIImage(systemName: "flip.horizontal.fill")]
    var randomAsset: PHAsset!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initItemCollectionView()
        getRandomImageFromLibrary()
    }

    // MARK: get a random image in device
    func getRandomImageFromLibrary()
    {
        if let asset = PHAsset.loadRandomPHAssetImageFromGallery()
        {
            randomAsset = asset
            let mainImage = randomAsset.fetchImage(widthSize: 500, heightSize: 500, contentMode: .aspectFill)
            cropImageView.image = mainImage
        }
    }
    
    func initItemCollectionView()
    {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ItemCollectionViewCell")
    }
}

// MARK: CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.initCell(cellImage: itemImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: 60, bottom: 50, right: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row
        {
        case 0: cropImageView.transform = cropImageView.transform.rotated(by: .pi/2 * -1)
        case 1: cropImageView.transform = cropImageView.transform.rotated(by: .pi/2)
        case 2: cropImageView.image = cropImageView.image?.flipped(.horizontal);
        case 3: cropImageView.image = cropImageView.image?.flipped(.vertical);
        default: print("Coming soon")
        }
    }
}
