//
//  NetworkResult.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import Foundation
enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
