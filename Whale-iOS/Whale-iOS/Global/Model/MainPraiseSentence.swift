//
//  MainPraiseSentence.swift
//  Whale-iOS
//
//  Created by DANNA LEE on 2021/06/09.
//

import Foundation

// MARK: - DataClass
struct MainPraiseSentence: Codable {
    let homePraise: HomePraise
}

// MARK: - HomePraise
struct HomePraise: Codable {
    let id: Int
    let todayPraise, praiseDescription: String

    enum CodingKeys: String, CodingKey {
        case id
        case todayPraise = "today_praise"
        case praiseDescription = "praise_description"
    }
}
