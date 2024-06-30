//
//  Error.swift
//  MeaningOut
//
//  Created by 최대성 on 6/30/24.
//

import Foundation


enum SearchError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}
