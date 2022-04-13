//
//  PhotoViewAlert.swift
//  My tasks  project
//
//  Created by Mahia113
//

import UIKit

class PhotoAlertView: UIView {

    @IBOutlet var alertPhotoView: UIView!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCustomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCustomView(){
        alertPhotoView = loadViewfromNib()
        alertPhotoView.frame = bounds
        alertPhotoView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        alertPhotoView.layer.cornerRadius = 25
        alertPhotoView.layer.masksToBounds =  true
        alertPhotoView.layer.borderWidth = 1.0
        alertPhotoView.layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(alertPhotoView)
    }
    
    func loadViewfromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AlertPhotoView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func actionButtonAcept(_ sender: Any) {
        alertPhotoView.removeFromSuperview()
    }
    
}
