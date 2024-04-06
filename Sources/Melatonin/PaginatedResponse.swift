//
//  PaginatedResponse.swift
//
//
//  Created by Zaid Rahhawi on 4/6/24.
//

import Foundation

public protocol PaginatedResponse {
    associatedtype Record
    associatedtype Metadata: PaginationMetadata = Pagination
    
    var records: [Record] { get }
    var pagination: Metadata { get }
}
