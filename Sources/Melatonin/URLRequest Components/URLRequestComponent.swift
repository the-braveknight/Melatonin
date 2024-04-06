//
//  File.swift
//  
//
//  Created by Zaid Rahhawi on 4/6/24.
//

import Foundation

public protocol URLRequestComponent {
    func build(_ request: inout URLRequest)
}
