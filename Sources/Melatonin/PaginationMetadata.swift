//
//  File.swift
//  
//
//  Created by Zaid Rahhawi on 4/6/24.
//

import Foundation

public protocol PaginationMetadata {
    var totalCount: Int { get }
    var totalPages: Int { get }
    var recordsPerPage: Int { get }
    var currentPage: Int { get }
}

public struct Pagination: PaginationMetadata {
    public let totalCount: Int
    public let totalPages: Int
    public let recordsPerPage: Int
    public let currentPage: Int
    
    public init(totalCount: Int, totalPages: Int, recordsPerPage: Int, currentPage: Int) {
        self.totalCount = totalCount
        self.totalPages = totalPages
        self.recordsPerPage = recordsPerPage
        self.currentPage = currentPage
    }
}
