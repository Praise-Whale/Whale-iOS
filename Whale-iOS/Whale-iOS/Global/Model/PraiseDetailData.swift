//
//  PraiseDetailData.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/16.
//

import Foundation

struct PraiseDetailData: Codable {
    let praiseCount: Int
    let collectionPraise: [CollectionPraise]
}
