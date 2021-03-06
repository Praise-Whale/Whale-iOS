//
//  APIConstants.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import Foundation
struct APIConstants {
    #if DEBUG
    static let baseURL = "http://54.180.177.198:3005/"
    #else
    static let baseURL = "http://54.180.177.198:3000/"
    #endif
    
    
    /// 메인 칭찬 문구 받아오는 API
    static let mainURL = baseURL + "home/"
    /// 로그인 API
    static let loginURL = baseURL + "users/signin"
    /// 최근 칭찬 유저 받아오기
    static let getRecentURL = baseURL + "praise/target"
    /// 최근 칭찬 유저 등록하기
    static let postRecentURL = baseURL + "praise/"
    
    static let signUpURL = baseURL + "users/signup"
    
    /// 레벨 정보 조회 API
    static let levelURL = baseURL + "users/home"
    /// 칭찬카드 전체조회 API
    static let praiseURL = baseURL + "praise/"
    
    static let praiseDetailURL = baseURL + "praise?praisedName="
    
    static let nicknameCheckURL = baseURL + "users/check/"
    
    static let nicknameChangeURL = baseURL + "users/nickname"
}
