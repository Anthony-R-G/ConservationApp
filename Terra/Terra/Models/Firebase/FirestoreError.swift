//
//  FirestoreError.swift
//  Terra
//
//  Created by Anthony Gonzalez on 7/25/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

enum FirestoreError: Error {
    case noSnapshot
    case rawError(Error)
    case unknown
}
