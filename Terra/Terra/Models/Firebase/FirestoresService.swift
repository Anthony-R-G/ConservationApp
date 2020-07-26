//
//  FirestoreService.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/13/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    static let manager = FirestoreService()
    private let db = Firestore.firestore()
    private init() {}
    
    func getAllSpeciesData(completion: @escaping (Result<[Species], FirestoreError>) -> ()) {
        db.collection("Species").getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(.rawError(error)))
                return
            }
            
            guard let snapshot = snapshot else {
                completion(.failure(.noSnapshot))
                return
            }
            
            let speciesData = snapshot.documents.compactMap({ (snapshot) -> Species? in
                let species = Species(from: snapshot.data())
                return species
            })
            completion(.success(speciesData))
        }
    }
}

