//
//  PaginatedResponse.swift
//  Example
//
//  Created by Zaid Rahhawi on 12/20/24.
//

import Foundation

struct PaginationMetadata {
    let currentPage: Int
    let totalPages: Int
    let totalCount: Int
    let recordsPerPage: Int
    
    init(totalCount: Int, totalPages: Int, recordsPerPage: Int, currentPage: Int) {
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.totalCount = totalCount
        self.recordsPerPage = recordsPerPage
    }
    
    init(from httpURLResponse: HTTPURLResponse) throws {
        guard let currentPage = httpURLResponse.value(forHTTPHeaderField: "x-pagination-page") else {
            throw NSError()
        }
        
        guard let currentPage = Int(currentPage) else {
            throw NSError()
        }
        
        guard let totalPages = httpURLResponse.value(forHTTPHeaderField: "x-pagination-pages") else {
            throw NSError()
        }
        
        guard let totalPages = Int(totalPages) else {
            throw NSError()
        }
        
        guard let totalCount = httpURLResponse.value(forHTTPHeaderField: "x-pagination-total") else {
            throw NSError()
        }
        
        guard let totalCount = Int(totalCount) else {
            throw NSError()
        }
        
        guard let perPage = httpURLResponse.value(forHTTPHeaderField: "x-pagination-limit") else {
            throw NSError()
        }
        
        guard let perPage = Int(perPage) else {
            throw NSError()
        }
        
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.totalCount = totalCount
        self.recordsPerPage = perPage
    }
}

struct PaginatedResponse<Item> {
    let items: [Item]
    let pagination: PaginationMetadata
}

extension PaginationMetadata {
    var firstPage: Int {
        return 1
    }
    
    var lastPage: Int {
        return totalPages
    }
    
    var nextPage: Int? {
        guard currentPage < totalPages else {
            return nil
        }
        
        return currentPage + 1
    }
    
    var previousPage: Int? {
        guard currentPage > 1 else {
            return nil
        }
        
        return currentPage - 1
    }
}
