//
//  PaginatedEndpoint.swift
//
//
//  Created by Zaid Rahhawi on 4/6/24.
//

import Foundation

public protocol PaginatedEndpoint: Endpoint where Response: PaginatedResponse {
    init(page: Int, recordsPerPage: Int)
    static func nextPage(from response: Response) -> Self?
    static func previousPage(from response: Response) -> Self?
    static func firstPage(from response: Response) -> Self
    static func lastPage(from response: Response) -> Self
}

public extension PaginatedEndpoint {
    static func nextPage(from response: Response) -> Self? {
        guard response.pagination.currentPage < response.pagination.totalPages else {
            return nil
        }
        
        return Self(page: response.pagination.currentPage + 1, recordsPerPage: response.pagination.recordsPerPage)
    }
    
    static func previousPage(from response: Response) -> Self? {
        guard response.pagination.currentPage > 1 else {
            return nil
        }
        
        return Self(page: response.pagination.currentPage - 1, recordsPerPage: response.pagination.totalPages)
    }
    
    static func firstPage(from response: Response) -> Self {
        Self(page: 1, recordsPerPage: response.pagination.recordsPerPage)
    }
    
    static func lastPage(from response: Response) -> Self {
        Self(page: response.pagination.totalPages, recordsPerPage: response.pagination.recordsPerPage)
    }
}
