//
//  Quote.swift
//  AmourX
//
//  Created by Fangcheng Song on 2020/1/13.
//  Copyright © 2020 Fangcheng Song. All rights reserved.
//

import Foundation

struct Quote: Codable {
    let quote: String
    let length: String
    let author: String
    let tags: [String]
    let category: String
    let date: String
    let permalink: String
    let title: String
    let background: String
    let id: String
}
