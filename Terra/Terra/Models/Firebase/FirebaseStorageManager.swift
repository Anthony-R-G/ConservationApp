//
//  FirebaseStorageManager.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/30/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import FirebaseUI


class FirebaseStorageService {
    
    enum imageType {
        case cell
        case detail
    }
    
    static var cellImageManager = FirebaseStorageService(type: .cell)
    
    static var detailImageManager = FirebaseStorageService(type: .detail)
    
    private let storage: Storage!
    private let storageReference: StorageReference
    private let imagesFolderReference: StorageReference
    
    private init(type: imageType) {
        storage = Storage.storage()
        storageReference = storage.reference()
        switch type {
        case .cell:
            imagesFolderReference = storageReference.child("Collection Cell Images")
        case .detail:
            imagesFolderReference = storageReference.child("Detail VC Images")
        }
    }
    
    func getImage(imageRefStr: String, imageView: UIImageView) {
        let cleanedStr = imageRefStr.lowercased().replacingOccurrences(of: " ", with: "")
        let animalImageReference = imagesFolderReference.child("\(cleanedStr).png")
        imageView.sd_setImage(with: animalImageReference)
    }
}
