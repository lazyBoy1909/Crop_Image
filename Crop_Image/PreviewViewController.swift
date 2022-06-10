//
//  PreviewViewController.swift
//  Crop_Image
//
//  Created by đào sơn on 09/06/2022.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet private weak var previewImageView: UIImageView!
    var previewImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Preview"
        addPreviewImage()
    }

    func addPreviewImage()
    {
        self.previewImageView.image = previewImage
    }

    @IBAction func saveButtonDidTap(_ sender: UIButton) {
        let alert = UIAlertController(title: "Save Image", message: "Do you want to save this image to your device?", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            UIImage.saveImage(image: self.previewImage)
            let successAlert = UIAlertController(title: "Save Image", message: "Your image was saved successfully in your photo library!", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            successAlert.addAction(confirmAction)
            self.present(successAlert, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
