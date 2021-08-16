//
//  APIConstants.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import Foundation
struct APIConstants {
    static let baseURL = "http://52.78.101.245:3005/"
    
    /// 메인 칭찬 문구 받아오는 API
    static let mainURL = baseURL + "home/"
    /// 로그인 API
    static let loginURL = baseURL + "users/signin"
    
    /// 레벨 정보 조회 API
    static let levelURL = baseURL + "users/home"
}
