//
//  LevelService.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/16.
//

import Foundation
import Alamofire

struct LevelService {
    static let shared = LevelService()
    
    func levelService(completion: @escaping (NetworkResult<Any>)->(Void)) {
        
        let url = APIConstants.levelURL
        
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
                completion(judgeLevelService(status: statusCode, data: data))
                
            case .failure(let err) :
                print(err)
            }
        }
    }
    
    private func judgeLevelService(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<LevelData>.self, from: data) else {
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
