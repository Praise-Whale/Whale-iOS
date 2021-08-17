//
//  RecentPraiseService.swift
//  Whale-iOS
//
//  Created by Danna Lee on 2021/08/13.
//

import Foundation
import Alamofire

struct RecentPraiseService {
    static let shared = RecentPraiseService()
    
    // MARK: - 최근 칭찬한 사람 이름 받아오기
    
    func getUser(completion: @escaping (NetworkResult<Any>)->(Void)) {
        
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        
        let url = APIConstants.getRecentURL
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
                completion(judgeGetUserService(status: statusCode, data: data))
                
            case .failure(let err) :
                print(err)
            }
        }
    }
    
    private func judgeGetUserService(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[RecentPraiseData]>.self, from: data) else {
            return .pathErr }
        
        switch status {
        case 200:
            return .success(decodedData.data)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    
    // MARK: - 최근 칭찬한 사람 이름 등록하기
    
    func postUser(id: Int, name: String, completion: @escaping (NetworkResult<Any>)->(Void)) {
        
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = formatter.string(from: Date())
        
        let url = APIConstants.postRecentURL + "\(id)"
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token" : token
        ]
        let body : Parameters = [
            "praisedName" : name,
            "created_at" : currentDate
        ]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
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
                completion(judgePostUserService(status: statusCode, data: data))
                
            case .failure(let err) :
                print(err)
            }
        }
    }
    
    private func judgePostUserService(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<RecentPraisePostResultData>.self, from: data) else {
            return .pathErr }
        
        switch status {
        case 200:
            return .success(decodedData.data)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
