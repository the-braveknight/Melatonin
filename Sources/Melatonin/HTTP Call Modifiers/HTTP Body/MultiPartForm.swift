//
//  MultiPartForm.swift
//  Melatonin
//
//  Created by Zaid Rahhawi on 3/6/25.
//

import Foundation

// MARK: - MultiPart Form Field Protocol
public protocol MultiPartFormField {
    var headers: [MultiPartFormFieldHeader] { get }
    var body: Data { get }
}

public extension MultiPartFormField {
    var headers: [MultiPartFormFieldHeader] { [] }
}

// MARK: - MultiPart Form Field Header Protocol
public protocol MultiPartFormFieldHeader {
    var fieldValue: String { get }
}

extension HTTPHeader where Self : MultiPartFormFieldHeader {
    public var fieldValue: String {
        "\(field): \(value)"
    }
}

// MARK: - Content-Type as a MultiPartFormFieldHeader
extension ContentType: MultiPartFormFieldHeader {}

// MARK: - Content-Disposition as a MultiPartFormFieldHeader
extension ContentDisposition: MultiPartFormFieldHeader {}

public struct MultiPartFormFieldWithAdditionalHeaders<Field: MultiPartFormField>: MultiPartFormField {
    public let headers: [MultiPartFormFieldHeader]
    public let body: Data
    
    init(field: Field, headers: [MultiPartFormFieldHeader]) {
        self.headers = field.headers + headers
        self.body = field.body
    }
}

// MARK: - MultiPart Form Field Extensions for Headers
public extension MultiPartFormField {
    func contentDisposition(_ disposition: Disposition.`Type`, _ parameters: MIMETypeParameter...) -> some MultiPartFormField {
        MultiPartFormFieldWithAdditionalHeaders(field: self, headers: [ContentDisposition(disposition, parameters: parameters)])
    }
    
    func contentDisposition(_ disposition: Disposition.`Type`, @ArrayBuilder<MIMETypeParameter> _ parameters: () -> [MIMETypeParameter]) -> some MultiPartFormField {
        MultiPartFormFieldWithAdditionalHeaders(field: self, headers: [ContentDisposition(disposition, parameters: parameters)])
    }
    
    func contentType(_ mimeType: MIMEType) -> some MultiPartFormField {
        MultiPartFormFieldWithAdditionalHeaders(field: self, headers: [ContentType(mimeType)])
    }
}

// MARK: - MultiPart Form Structure
public struct MultiPartForm: HTTPBodyModifier {
    let boundary: String
    let fields: [MultiPartFormField]
    
    public var data: Data? {
        var data = Data()
        let boundaryData = "--\(boundary)\r\n".data(using: .utf8)!
        let closingBoundaryData = "--\(boundary)--\r\n".data(using: .utf8)!
                
        for field in fields {
            data.append(boundaryData)
            
            let sortedHeaders = field.headers.sorted { $0 is ContentDisposition && !($1 is ContentDisposition) }
            
            for header in sortedHeaders {
                data.append("\(header.fieldValue)\r\n".data(using: .utf8)!)
            }
            
            data.append("\r\n".data(using: .utf8)!) // ✅ Ensure blank line before content
            
            // ✅ Append content
            data.append(field.body)
            data.append("\r\n".data(using: .utf8)!)
        }
        
        data.append(closingBoundaryData)
        return data
    }
    
    public init(boundary: String, fields: [MultiPartFormField]) {
        self.boundary = boundary
        self.fields = fields
    }
    
    public init(boundary: String, @ArrayBuilder<MultiPartFormField> fields: () -> [MultiPartFormField]) {
        self.init(boundary: boundary, fields: fields())
    }
}

// MARK: - Text Form Field
public struct Text: MultiPartFormField {
    public let value: String
    
    public var body: Data {
        Data(value.utf8)
    }
    
    public init(_ value: String) {
        self.value = value
    }
}

// MARK: - File Form Field
public struct File: MultiPartFormField {
    public let body: Data
    
    public init(data: Data) {
        self.body = data
    }
    
    public init(filePath: String) {
        let url = URL(fileURLWithPath: filePath)
        guard let data = try? Data(contentsOf: url) else {
            preconditionFailure("Could not read file at: \(filePath)")
        }
        self.body = data
    }
}

extension HTTPCall {
    func multiPartForm(boundary: String, @ArrayBuilder<MultiPartFormField> fields: () -> [MultiPartFormField]) -> some HTTPCall {
        let mimeType = MIMEType(type: .multipart, subType: .formData, parameters: [Boundary(boundary)])
        return contentType(mimeType).modifier(MultiPartForm(boundary: boundary, fields: fields))
    }
}
