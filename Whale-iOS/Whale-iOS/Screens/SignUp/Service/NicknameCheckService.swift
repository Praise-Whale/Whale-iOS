//
//  NicknameCheckService.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/11.
//

import Foundation
import Alamofire

struct NicknameCheckService {
    static let shared = NicknameCheckService()
    
    func checkNickname(nickname:String, completion: @escaping (NetworkResult<Any>) -> (Void)){
      
        //한글 인코딩
        let url = APIConstants.nicknameCheckURL + nickname
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let encodedUrl = URL(string: encodedString)!
        
        let header: HTTPHeaders = [ "Content-Type":"application/json"]
        let dataRequest = AF.request(encodedUrl,
                                     method: .get,
                                     encoding: JSONEncoding.default, headers: header)
        
        
        dataRequest.responseData {(response) in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return
                }
                guard let data = response.value else {
                    return
                }
                completion(judgeData(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail) }
        }
    }
    
    
    private func judgeData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<BasicData>.self, from: data) else {
            return .pathErr }
        switch status {
        case 200:
            print("닉네임 중복체크 성공")
            return .success(decodedData.message)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail }
    }
}
