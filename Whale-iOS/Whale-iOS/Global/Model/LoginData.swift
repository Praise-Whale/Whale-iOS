//
//  LoginData.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/08.
//

import Foundation

// MARK: - DataClass
struct LoginData: Codable {
    let accessToken, refreshToken: String
}
