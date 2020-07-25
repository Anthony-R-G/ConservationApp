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
    
    func getAllSpeciesData(completion: @escaping (Result<[Species], Error>) -> ()) { 
        db.collection("Species").getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let speciesData = snapshot?.documents.compactMap({ (snapshot) -> Species? in
                    let species = Species(from: snapshot.data())
                    return species
                })
                completion(.success(speciesData ?? []))
            }
        }
    }
}
