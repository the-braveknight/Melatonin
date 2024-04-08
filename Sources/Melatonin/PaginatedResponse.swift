//
//  PaginatedResponse.swift
//
//
//  Created by Zaid Rahhawi on 4/6/24.
//

import Foundation

public protocol PaginatedResponse {
    associatedtype Metadata: PaginationMetadata = Pagination
    var pagination: Metadata { get }
}
