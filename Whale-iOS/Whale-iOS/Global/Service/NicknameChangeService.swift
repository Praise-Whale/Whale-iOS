//
//  NicknameChangeService.swift
//  Whale-iOS
//
//  Created by Danna Lee on 2021/10/01.
//

import Foundation
import Alamofire

struct NicknameChangeService {
    static let shared = NicknameChangeService()
    
    // MARK: - 메인 칭찬 메시지 받아오기
    
    func nicknameChangeService(newNickname: String, completion: @escaping (NetworkResult<Any>)->(Void)) {
        
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        let nickname: String = UserDefaults.standard.string(forKey: "nickName") ?? ""
        
        let url = APIConstants.nicknameChangeURL
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "token" : token
        ]
        let body: Parameters = [
            "nickName" : nickname,
            "newNickName" : newNickname
        ]
        let dataRequest = AF.request(url,
                                     method: .put,
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
                completion(judgeNicknameService(status: statusCode, data: data))
                
            case .failure(let err) :
                print(err)
            }
        }
    }
    
    private func judgeNicknameService(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<BasicData>.self, from: data) else {
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
