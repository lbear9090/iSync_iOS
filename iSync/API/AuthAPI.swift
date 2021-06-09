//
//  AuthAPI.swift
//  iSync
//
//  Created by Lucky on 11/17/20.
//  Copyright © 2020 Lucky. All rights reserved.
//

import Foundation
import Alamofire

class AuthAPI: BaseAPI{
    public static let shared = AuthAPI()
    
    func checkHealth(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String?) -> Void){
        getRequestForStatus(url: "", param: nil, token: false) {
            onSuccess()
        } onError: { (error) in
            onError(error?.message?[0] ?? "")
        }
    }
    
    func signup(firstName: String, lastName: String, email : String, password: String, screenName: String, phoneNumber: String, onSuccess: @escaping(_ data: AuthResult?) -> Void, onError: @escaping(_ errorMessage: String?) -> Void){
        let param = ["firstName": firstName,
                     "lastName": lastName,
                     "email": email,
                     "password": password,
                     "screenName": screenName,
                     "phoneNumber": phoneNumber
        ]

        postRequest(url: "auth/register", param: param, token: false) { (response: AuthResult) in
            onSuccess(response)
        } onError: { (error) in
            onError(error?.message?[0] ?? "")
        }
    }
    
    func login(email: String, password: String, onSuccess: @escaping(_ data: AuthResult?) -> Void, onError: @escaping(_ errorMessage: String?) -> Void){
        let param = ["email": email,
                     "password": password
        ]
        
        postRequest(url: "login.php", param: param, token: false) { (response: AuthResult) in
            onSuccess(response)
        } onError: { (error) in
            onError(error?.message?[0] ?? "")
        }
    }
    
    func forgotPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String?) -> Void){
        let param = ["email": email]
        
        postRequestForStatus(url: "auth/forgot-password", param: param, token: false) {
            onSuccess()
        } onError: { (error) in
            onError(error?.message?[0] ?? "")
        }
    }
    
    func resetPassword(email: String, code: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String?) -> Void){
        let param = ["email": email,
                     "code": code,
                     "password": password]
        
        postRequestForStatus(url: "auth/reset-password", param: param, token: false) {
            onSuccess()
        } onError: { (error) in
            onError(error?.message?[0] ?? "")
        }
    }
    
    func setUserImage(image: String, onSuccess: @escaping(_ data: AuthResult) -> Void, onError: @escaping(_ errorMessage: String?) -> Void) {
        let param = [
            "photo": image
        ]
        
        postRequest(url: "auth/photo/encoded", param: param, token: (g_token != nil)) { (response: AuthResult) in
            onSuccess(response)
        } onError: { (error) in
            onError(error?.message?[0] ?? "")
        }
    }
}
