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
    var resizableView: ResizableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initItemCollectionView()
        getRandomImageFromLibrary()
        addCropView()
    }

    func addCropView()
    {
        self.resizableView = ResizableView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        resizableView.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1.0, alpha: 0.2)
        let imageFrame = self.cropImageView.frame
        resizableView!.frame = CGRect(x: imageFrame.origin.x, y: imageFrame.origin.y, width: imageFrame.width-16, height: imageFrame.height - 50)
        self.view.addSubview(resizableView!)
    }
    
    // MARK: get a random image in device
    func getRandomImageFromLibrary()
    {
        if let asset = PHAsset.loadRandomPHAssetImageFromGallery()
        {
            randomAsset = asset
            let mainImage = randomAsset.fetchImage(widthSize: cropImageView.frame.width, heightSize: cropImageView.frame.height, contentMode: .aspectFit)
            cropImageView.image = mainImage
        }
    }
    
    func initItemCollectionView()
    {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ItemCollectionViewCell")
    }
    @IBAction func okButtonDidTap(_ sender: UIButton) {
        let previewViewController = PreviewViewController()
        let xValue = resizableView.frame.origin.x - cropImageView.frame.origin.x - cropImageView.contentRect.minX
        let yValue = resizableView.frame.origin.y - cropImageView.frame.origin.y - cropImageView.contentRect.minY
        let toRect = CGRect(x: xValue , y: yValue , width: resizableView.frame.width , height: resizableView.frame.height )
        let previewImage = UIImage.cropImage(image: self.cropImageView.image!, toRect: toRect )
        if let image = previewImage
        {
            previewViewController.previewImage = image
            self.navigationController?.pushViewController(previewViewController, animated: true)
        }
        
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
