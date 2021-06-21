//
//  BaseAPI.swift
//  iSync
//
//  Created by Lucky on 11/19/20.
//  Copyright © 2020 Lucky. All rights reserved.
//

import Foundation
import Alamofire

class BaseAPI{
    func getRequestForStatus(url: String, param: Parameters?, token: Bool = true, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: APIError?) -> Void){
        let url = baseURL + url
        var header = ["Content-Type": "application/json",
                      "Accept": "*/*"] as HTTPHeaders
        if(token && !isEmpty(g_token)){
            header["Apitoken"] = "Bearer " + g_token!
        }
        let param = param
        let request = AF.request(url, method: .get, parameters: param, encoding: JSONEncoding.default, headers: header)
        request.validate().responseJSON { (response) in
            print(response.debugDescription)
            switch response.result{
            case .success:
                onSuccess()
                break
            case .failure(let error):
                guard let data = response.data else {
                    onError(APIError(error: "Error", message: [error.localizedDescription]))
                    return
                }
                let errorData = try! JSONDecoder().decode(APIError.self, from: data)
                onError(errorData)
                break
            }
        }
    }
    
    func getRequest<T>(url: String, param: Parameters?, token: Bool = true, onSuccess: @escaping(_ data: T) -> Void, onError: @escaping(_ errorMessage: APIError?) -> Void) where T : Decodable{
        let url = baseURL + url
        var header = ["Content-Type": "application/json",
                      "Accept": "*/*"] as HTTPHeaders
        if(token && !isEmpty(g_token)){
            header["Apitoken"] = "Bearer " + g_token!
        }
        let param = param
        let request = AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: header)
        request.validate().responseJSON { (response) in
            print(response.debugDescription)
            switch response.result{
            case .success:
                guard let data = response.data else {
                    onError(APIError(error: "Empty Data", message: ["Empty Data"]))
                    return
                }
                let decodedData = try! JSONDecoder().decode(T.self, from: data)
                onSuccess(decodedData)
                break
            case .failure(let error):
                guard let data = response.data else {
                    onError(APIError(error: "Error", message: [error.localizedDescription]))
                    return
                }
                let errorData = try! JSONDecoder().decode(APIError.self, from: data)
                onError(errorData)
                break
            }
        }
    }
    
    func postRequestForStatus(url: String, param: Parameters?, token: Bool = true, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: APIError?) -> Void){
        let url = baseURL + url
        var header = ["Content-Type": "application/json",
                      "Accept": "*/*"] as HTTPHeaders
        if(token && !isEmpty(g_token)){
            header["Apitoken"] = "Bearer " + g_token!
        }
        
        let param = param
        let request = AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
        request.validate().responseJSON { (response) in
            print(response.debugDescription)
            switch response.result{
            case .success:
                onSuccess()
                break
            case .failure(let error):
                guard let data = response.data else {
                    onError(APIError(error: "Error", message: [error.localizedDescription]))
                    return
                }
                let errorData = try! JSONDecoder().decode(APIError.self, from: data)
                onError(errorData)
                break
            }
        }
    }
    
    func postRequest<T>(url: String, param: Parameters?, token: Bool = true, onSuccess: @escaping(_ data: T) -> Void, onError: @escaping(_ errorMessage: APIError?) -> Void) where T : Decodable{
        let url = baseURL + url
        var header = ["Content-Type": "application/json",
                      "Accept": "*/*"] as HTTPHeaders
        
        if(token && !isEmpty(g_token)){
            header["Apitoken"] = "Bearer " + g_token!
        }
        
        let param = param
        let request = AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
        request.validate().responseJSON { (response) in
            print(response.debugDescription)
            switch response.result{
            case .success:
                guard let data = response.data else {
                    onError(APIError(error: "Empty Data", message: ["Empty Data"]))
                    return
                }
                let decodedData = try! JSONDecoder().decode(T.self, from: data)
                onSuccess(decodedData)
                break
            case .failure(let error):
                guard let data = response.data else {
                    onError(APIError(error: "Error", message: [error.localizedDescription]))
                    return
                }
                let errorData = try! JSONDecoder().decode(APIError.self, from: data)
                onError(errorData)
                break
            }
        }
    }
}
