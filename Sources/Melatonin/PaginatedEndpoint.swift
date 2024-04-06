//
//  PaginatedEndpoint.swift
//
//
//  Created by Zaid Rahhawi on 4/6/24.
//

import Foundation

public protocol PaginatedEndpoint: Endpoint where Response: PaginatedResponse {
    init(page: Int, recordsPerPage: Int)
}
