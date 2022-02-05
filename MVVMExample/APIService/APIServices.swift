//
//  APIServices.swift
//  MVVMExample
//
//  Created by Mac on 1/31/22.
//

import UIKit

import Alamofire

class APIServices {
    public init() {}
    static let instance = APIServices()
    func getData<T: Decodable, E: Decodable>(url: URL, method: HTTPMethod ,params: Parameters?, encoding: ParameterEncoding ,headers: HTTPHeaders? ,completion: @escaping (T?, E?, Error?)->()) {
        
        Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
            .validate(statusCode: 200...300)
            .responseJSON { (response) in
                switch response.result {
                case .success(_):
                    guard let data = response.data else { return }
                    do {
                        let jsonData = try JSONDecoder().decode(T.self, from: data)
                        completion(jsonData, nil, nil)
                    } catch let jsonError {
                        print(jsonError)
                    }
                    
                case .failure(let error):
                    guard let data = response.data else {
                        completion(nil, nil, error)
                        return
                    }
                    guard let statusCode = response.response?.statusCode else {
                        completion(nil, nil, error)
                        return
                    }
                    switch statusCode {
                    case 400..<500:
                        do {
                            let jsonError = try JSONDecoder().decode(E.self, from: data)
                            completion(nil, jsonError, nil)
                        } catch let jsonError {
                            print(jsonError)
                        }
                    default:
                        completion(nil, nil, error)
                    }
                }
        }
    }
}
