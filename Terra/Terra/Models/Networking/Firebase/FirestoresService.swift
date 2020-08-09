//
//  FirestoreService.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/13/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation
import FirebaseFirestore

//TODO: Possible Refactor with Combine?
class FirestoreService {
    static let manager = FirestoreService()
    private let db = Firestore.firestore()
    private init() {}
    
    func getAllSpeciesData(completion: @escaping (Result<[Species], FirestoreError>) -> Void) {
        getAllObjects(collectionName: "Species", completion: completion)
    }
    
    private func getAllObjects<T: FirebaseConvertible>(collectionName name: String,
                                                          completion: @escaping (Result<[T], FirestoreError>) -> Void) {
           db.collection(name).getDocuments { (snapshot, error) in
               if let error = error {
                   completion(.failure(.rawError(error)))
                   return
               }
            
               guard let snapshot = snapshot else {
                   completion(.failure(.noSnapshot))
                   return
               }
            
            
               let objects = snapshot.documents.compactMap { T(fromFirebaseDict: $0.data()) }
               completion(.success(objects))
           }
       }
}

