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
        case callout
        case learnMoreOverview
    }
    
    static var cellImageManager = FirebaseStorageService(type: .cell)
    
    static var detailImageManager = FirebaseStorageService(type: .detail)
    
    static var calloutImageManager = FirebaseStorageService(type: .callout)
    
    static var learnMoreOverviewImageManager = FirebaseStorageService(type: .learnMoreOverview)
    
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
        case .callout:
            imagesFolderReference = storageReference.child("Callout Images")
            
        case .learnMoreOverview:
            imagesFolderReference = storageReference.child("Learn More Overview Images")
        }
    }
    
    func getImage(for speciesName: String, setTo imageView: UIImageView) {
        let cleanedStr = speciesName.lowercased().replacingOccurrences(of: " ", with: "")
        let animalImageReference = imagesFolderReference.child("\(cleanedStr).png")
        imageView.sd_imageTransition = .fade
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: animalImageReference, placeholderImage: UIImage(named: "black"))
    }
}
