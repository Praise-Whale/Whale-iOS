//
//  PraiseService.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/12.
//

import Foundation
import Alamofire

struct PraiseService {
    static let shared = PraiseService()
    
    func praiseDateService(year: String, month: String, completion: @escaping (NetworkResult<Any>)->(Void)) {
        
        let url = APIConstants.praiseURL + year + "/" + month
        
        var token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        if let savedToken = UserDefaults.standard.string(forKey: "refreshToken") {
            token = savedToken
        }
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token" : token
        ]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { (response) in
            switch response.result {
            case .success :
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let data = response.value else {
                    return
                }
                completion(judgePraiseService(status: statusCode, data: data))
                
            case .failure(let err) :
                print(err)
            }
        }
    }
    
    func praiseLankService(completion: @escaping (NetworkResult<Any>)->(Void)) {
        
        let url = APIConstants.praiseURL + "ranking"
        
        var token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        if let savedToken = UserDefaults.standard.string(forKey: "refreshToken") {
            token = savedToken
        }
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token" : token
        ]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { (response) in
            switch response.result {
            case .success :
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let data = response.value else {
                    return
                }
                completion(judgePraiseLankService(status: statusCode, data: data))
                
            case .failure(let err) :
                print(err)
            }
        }
    }
    
    func praiseDetailService(nickName: String, completion: @escaping (NetworkResult<Any>)->(Void)) {
        
        //한글 인코딩
        let url = APIConstants.praiseDetailURL + nickName
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let encodedUrl = URL(string: encodedString)!
        
        var token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        if let savedToken = UserDefaults.standard.string(forKey: "refreshToken") {
            token = savedToken
        }
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token" : token
        ]
        
        let dataRequest = AF.request(encodedUrl,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { (response) in
            switch response.result {
            case .success :
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let data = response.value else {
                    return
                }
                completion(judgePraiseDetailService(status: statusCode, data: data))
                
            case .failure(let err) :
                print(err)
            }
        }
    }
    
    private func judgePraiseService(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<PraiseData>.self, from: data) else {
            return .pathErr }
        
        switch status {
        case 200:
            return .success(decodedData.data ?? "None-Data")
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgePraiseLankService(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<PraiseRankData>.self, from: data) else {
            return .pathErr }
        
        switch status {
        case 200:
            return .success(decodedData.data ?? "None-Data")
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgePraiseDetailService(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<PraiseDetailData>.self, from: data) else {
            return .pathErr }
        
        switch status {
        case 200:
            return .success(decodedData.data ?? "None-Data")
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
