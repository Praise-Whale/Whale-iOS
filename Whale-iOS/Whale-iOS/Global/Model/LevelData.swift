//
//  LevelData.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/16.
//

import Foundation

// MARK: - LevelData
struct LevelData: Codable {
    let nickName, whaleName: String
    let userLevel, praiseCount: Int
    let levelUpNeedCount: Int?
}
