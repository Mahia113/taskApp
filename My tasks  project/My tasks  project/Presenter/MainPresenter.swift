//
//  MainPresenter.swift
//  My tasks  project
//
//  Created by Mahia113
//

import FirebaseStorage
import FirebaseDatabase

protocol MainViewControllerDelegate:NSObjectProtocol {
    func photoUploaded(urlOfPhoto: String)
    func errorUploadingPhoto(error: String)
    func backGroundColorFromDBRealTime(color: String)
    func errorGettingCharts(error: String)
}

class MainPresenter {
    
    weak private var mainViewControllerDelegate: MainViewControllerDelegate?
    let errorUploadingPhoto = "Uh-oh, an error occurred!"
    let errorGettingUrlPhoto = "Uh-oh, an error occurred. File was uploaded but something something is wrong.!"
    let preRefPhoto = "my-photo-"
    let rootReferenceImage = "images/"
    let dateFormat = "MM-dd-yyyy"
    let backGroundKey = "background_for_view"
        
    func setViewDelegate(mainViewControllerDelegate: MainViewControllerDelegate?){
        self.mainViewControllerDelegate = mainViewControllerDelegate
    }
    
    func uploadPhoto(image: Data?){
        let imageRef = getStorageReference()
                
        imageRef.putData(image!, metadata: nil, completion: { (metadata, error) in
            
            imageRef.downloadURL { (url, error) in
              guard let downloadURL = url else {
                  self.mainViewControllerDelegate?.errorUploadingPhoto(error: self.errorGettingUrlPhoto)
                return
              }
                self.mainViewControllerDelegate?.photoUploaded(urlOfPhoto: downloadURL.absoluteString)
            }
            
        })
    }
    
    func startListeningDataBaseRealtime() {
        let ref = getDataBaseRealTimeReference()
        ref.observe(DataEventType.value, with: { snapshot in
            let value = snapshot.value as? Dictionary<String, String>
            let hexColor = value![self.backGroundKey]
            self.mainViewControllerDelegate?.backGroundColorFromDBRealTime(color: hexColor!)
        })
    }
    
    private func getDataBaseRealTimeReference() -> DatabaseReference {
        return Database.database().reference()
    }
    
    private func getStorageReference() -> StorageReference {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let nameFile = preRefPhoto+getDateString()
        return storageRef.child(rootReferenceImage+nameFile)
    }
    
    private func getDateString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}
