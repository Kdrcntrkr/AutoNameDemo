//
//  FetchManifacturer.swift
//  AutoDemo
//
//  Created by Kadircan Türker on 19.09.2021.
//

import Foundation

enum FetchManifacturer {
    struct Request: Encodable {
        let page: Int
        let pageSize: Int
    }
    
    struct Response: Codable {
        let wkda: [String : String]
    }
}
