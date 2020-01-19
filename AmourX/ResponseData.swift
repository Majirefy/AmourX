//
//  ResponseData.swift
//  AmourX
//
//  Created by Fangcheng Song on 2020/1/18.
//  Copyright © 2020 Fangcheng Song. All rights reserved.
//

import Foundation

struct ResponseData: Codable {
    let success: Success
    let contents: Contents
}

struct Success: Codable {
    let total: Int
}

struct Contents: Codable {
    let quotes: [Quote]
    let copyright: String
}
