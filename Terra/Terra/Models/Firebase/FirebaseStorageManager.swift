//
//  FirebaseStorageManager.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/30/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import FirebaseStorage


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
    
    init(type: imageType) {
        storage = Storage.storage()
        storageReference = storage.reference()
        switch type {
        case .cell:
            imagesFolderReference = storageReference.child("Collection Cell Images")
        case .detail:
            imagesFolderReference = storageReference.child("Detail VC Images")
        
        }
    }
 
    func getImage(url: String, completion: @escaping (Result<UIImage,Error>) -> ()) {
        imagesFolderReference.storage.reference(forURL: url).getData(maxSize: 2000000) { (data, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            }
        }
    }
}
