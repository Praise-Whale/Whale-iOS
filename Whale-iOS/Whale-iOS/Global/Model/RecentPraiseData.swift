//
//  RecentPraiseData.swift
//  Whale-iOS
//
//  Created by Danna Lee on 2021/08/13.
//

import Foundation

// MARK: - DataClass
struct RecentPraiseData: Codable {
    let praisedName: String
}

struct RecentPraisePostResultData: Codable {
    let toastCount: Int
    let levelCheck: Bool
}
