//
//  ViewController.swift
//  My tasks  project
//
//  Created by Mahia113.
//

import UIKit
import Toast

class MainViewController: UIViewController, MainViewControllerDelegate {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var buttonPhoto: UIButton!
    @IBOutlet weak var buttonGraphics: UIButton!
    @IBOutlet weak var buttonUpload: UIButton!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var labelPhotoDescription: UILabel!
    @IBOutlet weak var imageTaked: UIImageView!
    
    var customAlert = PhotoAlertView()
    
    let messageAlert = "Choose an option for your photo."
    let titleAlert = "Photo options"
    let titleActionSee = "See photo"
    let titleActionTake = "Take / Retake"
    let titleActionCancel = "Cancel"
    let labelDescriptionNormal = "Your photo"
    let labelDescriptionError = "For show an image, first take one."
    let labelDescriptionUploaError = "For uplod an image, first take one."
    let textSuccesUploaded = "Your photo was uploaded."
    let textErrorUploaded = "Your photo was not uploaded. Contact to admin."
    let textSuccesChangeBackground = "Background color changed from Data Base Real Time."
    
    private let mainPresenter = MainPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCornersToView(view: cardView)
        mainPresenter.setViewDelegate(mainViewControllerDelegate: self)
        mainPresenter.startListeningDataBaseRealtime()
    }
    
    @IBAction func photoAction(_ sender: Any) {
        alertPhoto(message: messageAlert, title: titleAlert)
    }
    
    @IBAction func uploadPhotoAction(_ sender: Any) {
        if imageTaked.image != nil {
            mainPresenter.uploadPhoto(image: imageTaked.image?.pngData())
        } else {
            labelPhotoDescription.text = labelDescriptionUploaError
        }
    }
    
    func photoUploaded(urlOfPhoto: String) {
        view.makeToast(textSuccesUploaded, duration: 3.0, position: .bottom)
    }
    
    func errorUploadingPhoto(error: String) {
        view.makeToast(textErrorUploaded, duration: 3.0, position: .bottom)
    }
    
    func backGroundColorFromDBRealTime(color: String) {
        view.backgroundColor = UIColor(hexString: color)
        view.makeToast(textSuccesChangeBackground, duration: 3.0, position: .bottom)
    }
    
    func errorGettingCharts(error: String) {
        view.makeToast(error, duration: 3.0, position: .bottom)
    }
    
    func addCornersToView(view: UIView) {
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.cornerRadius = 30
    }

}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    func alertPhoto(message: String, title: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle:.actionSheet)
    
        let seeAction = UIAlertAction(title: titleActionSee, style: .default, handler: { action in
            self.addAlertPhoto()
        })
    
        let takeAction = UIAlertAction(title: titleActionTake, style: .default, handler: { action in
            self.takePhoto()
        })
    
        let cancelAction = UIAlertAction(title: titleActionCancel, style: .cancel, handler: nil)

        alertController.addAction(seeAction)
        alertController.addAction(takeAction)
        alertController.addAction(cancelAction)
      
        self.present(alertController, animated: true, completion: nil)
    }
    
    func takePhoto(){
        let vc = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            vc.sourceType = .camera
        } else{
            vc.sourceType = .photoLibrary
        }
        
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            print("Image not found!")
            return
        }
        self.labelPhotoDescription.text = labelDescriptionNormal
        imageTaked.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func addAlertPhoto(){
        if self.imageTaked.image != nil {
            self.labelPhotoDescription.text = self.labelDescriptionNormal
            self.customAlert.imageViewPhoto.image = imageTaked.image!
            self.customAlert.frame = CGRect(x: 0, y: 0, width: 350, height: 500)
            self.customAlert.center = CGPoint(x: (self.view.frame.width)/2, y: (self.view.frame.height)/2)
            self.view.addSubview(self.customAlert)
        }else{
            self.labelPhotoDescription.text = self.labelDescriptionError
        }
    }
    
}
