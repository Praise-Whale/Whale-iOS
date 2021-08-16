//
//  PraiseLankData.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/16.
//

import Foundation

// MARK: - PraiseLankData
struct PraiseRankData: Codable {
    let totalPraiserCount: Int
    let rankingCountResult: [RankingCountResult]
}

// MARK: - RankingCountResult
struct RankingCountResult: Codable {
    let praisedName: String
    let praiserCount: Int
}
