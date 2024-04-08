//
//  GoRESTEndpoint.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import Foundation
import Melatonin

protocol GoRESTEndpoint: Endpoint {}

extension GoRESTEndpoint {
    var host: String { "gorest.co.in" }
}

struct GoRESTPaginatedResponse<Record: Decodable>: PaginatedResponse {
    let records: [Record]
    let pagination: Pagination
}

protocol GoRESTPaginatedEndpoint: GoRESTEndpoint {
    associatedtype Record: Decodable where Response == GoRESTPaginatedResponse<Record>
}

extension GoRESTPaginatedEndpoint {
    func pagination(from response: URLResponse) throws -> Pagination {
        guard let response = response as? HTTPURLResponse else {
            throw APIError(code: .invalidResponse)
        }
        
        guard let limit = response.value(forHTTPHeaderField: "x-pagination-limit"),
              let page = response.value(forHTTPHeaderField: "x-pagination-page"),
              let pages = response.value(forHTTPHeaderField: "x-pagination-pages"),
              let total = response.value(forHTTPHeaderField: "x-pagination-total") else {
            throw APIError(code: .missingPaginationHeader)
        }
        
        guard let totalCount = Int(total), let totalPages = Int(pages), let recordsPerPage = Int(limit), let currentPage = Int(page) else {
            throw APIError(code: .invalidPaginationHeader)
        }
        
        return Pagination(totalCount: totalCount, totalPages: totalPages, recordsPerPage: recordsPerPage, currentPage: currentPage)
    }
    
    func parse(data: Data, urlResponse: URLResponse) throws -> Response {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let records = try decoder.decode([Record].self, from: data)
        let pagination = try pagination(from: urlResponse)
        return Response(records: records, pagination: pagination)
    }
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }
}

struct APIError: LocalizedError {
    enum Code: Int {
        case invalidResponse
        case missingPaginationHeader
        case invalidPaginationHeader
    }
    
    let code: Code
}
