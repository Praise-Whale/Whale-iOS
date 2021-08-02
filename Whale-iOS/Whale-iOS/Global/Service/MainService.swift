//
//  MainService.swift
//  Whale-iOS
//
//  Created by DANNA LEE on 2021/06/09.
//

import Foundation
import Alamofire

struct MainService {
    static let shared = MainService()
    
    // MARK: - 메인 칭찬 메시지 받아오기
    
    func mainService(id:Int, completion: @escaping (NetworkResult<Any>)->(Void)) {
        
        var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4Ijo2LCJpYXQiOjE2Mjc5MjYyMTgsImV4cCI6MTYzMDUxODIxOCwiaXNzIjoicHJhaXNlIn0.AIv-crWxnFfhorn8T_-oCEFPXXCr3ohCOuQ7CuyRNvM"
        if let savedToken = UserDefaults.standard.string(forKey: "token") {
            token = savedToken
        }
        
        let url = APIConstants.mainURL + "\(id)"
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
                completion(judgeMainService(status: statusCode, data: data))
                
            case .failure(let err) :
                print(err)
            }
        }
    }
    
    private func judgeMainService(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<MainPraiseSentence>.self, from: data) else {
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
