//
//  NetworkError.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/3/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case other(rawError: Error)
}
