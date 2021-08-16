//
//  PraiseData.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/12.
//

import Foundation

// MARK: - PraiseData
struct PraiseData: Codable {
    let praiseCount: Int
    let firstDate: FirstDate
    let collectionPraise: [CollectionPraise]
}

// MARK: - CollectionPraise
struct CollectionPraise: Codable {
    let praisedName, createdAt: String
    let todayPraise: String

    enum CodingKeys: String, CodingKey {
        case praisedName
        case createdAt = "created_at"
        case todayPraise = "today_praise"
    }
}

// MARK: - FirstDate
struct FirstDate: Codable {
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
    }
}
