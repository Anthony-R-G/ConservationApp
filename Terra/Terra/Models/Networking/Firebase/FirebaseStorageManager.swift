//
//  FirebaseStorageManager.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/30/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import FirebaseUI


final class FirebaseStorageService {
    enum imageType {
        case cell
        case cover
        case callout
        case detailOverview
        case detailHabitat
        case detailThreats
    }
    
    static var cellImageManager = FirebaseStorageService(type: .cell)
    
    static var coverImageManager = FirebaseStorageService(type: .cover)
    
    static var calloutImageManager = FirebaseStorageService(type: .callout)
    
    static var detailOverviewImageManager = FirebaseStorageService(type: .detailOverview)
    
    static var detailHabitatImageManager = FirebaseStorageService(type: .detailHabitat)
    
    static var detailThreatsImageManager = FirebaseStorageService(type: .detailThreats)
    
    
    private let storage: Storage!
    private let storageReference: StorageReference
    private let imagesFolderReference: StorageReference
    
    private init(type: imageType) {
        storage = Storage.storage()
        storageReference = storage.reference()
        switch type {
            
        case .cell:
            imagesFolderReference = storageReference.child("Collection Cell Images")
            
        case .cover:
            imagesFolderReference = storageReference.child("Cover VC Images")
            
        case .callout:
            imagesFolderReference = storageReference.child("Callout Images")
            
        case .detailOverview:
            imagesFolderReference = storageReference.child("Detail Overview Images")
            
        case .detailHabitat:
            imagesFolderReference = storageReference.child("Detail Habitat Images")
            
        case .detailThreats:
            imagesFolderReference = storageReference.child("Detail Threats Images")
        }
    }
    
    func getImage(for speciesName: String, setTo imageView: UIImageView) {
        
        let animalImageReference = imagesFolderReference.child("\(speciesName.lowercaseAlphaNumericsOnly).png")
        imageView.sd_imageTransition = .fade(duration: 1.2)
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    
        //TODO: -- Change SDWebImageOptions in release build
        imageView.sd_setImage(with: animalImageReference,
                              maxImageSize: 11 * 1024 * 1024,
                              placeholderImage: UIImage(named: "black"),
                              options: [.scaleDownLargeImages],
                              completion: nil)
    }
}
