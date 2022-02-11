//
//  FetchCarTypes.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 19.09.2021.
//

import Foundation

enum FetchCarTypes {
    struct Request: Encodable {
        let manufacturerKey: String
    }
    
    struct Response: Codable {
        let wkda: [String : String]
    }
}
