//
//  File.swift
//  
//
//  Created by Zaid Rahhawi on 4/6/24.
//

import Foundation

public protocol PaginatedResponse {
    associatedtype Endpoint: PaginatedEndpoint
    associatedtype Record
    associatedtype Metadata: PaginationMetadata = Pagination
    
    var records: [Record] { get }
    var pagination: Metadata { get }
    
    var next: Endpoint? { get }
    var previous: Endpoint? { get }
    var first: Endpoint { get }
    var last: Endpoint { get }
}

public extension PaginatedResponse {
    var next: Endpoint? {
        if pagination.currentPage < pagination.totalPages {
            return Endpoint(page: pagination.currentPage + 1, recordsPerPage: pagination.recordsPerPage)
        }
        
        return nil
    }
    
    var previous: Endpoint? {
        if pagination.currentPage > 1 {
            return Endpoint(page: pagination.currentPage - 1, recordsPerPage: pagination.recordsPerPage)
        }
        
        return nil
    }
    
    var first: Endpoint {
        Endpoint(page: 1, recordsPerPage: pagination.recordsPerPage)
    }
    
    var last: Endpoint {
        Endpoint(page: pagination.totalPages, recordsPerPage: pagination.recordsPerPage)
    }
}
