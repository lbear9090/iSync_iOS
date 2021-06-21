//
//  AuthAPI.swift
//  iSync
//
//  Created by Lucky on 11/17/20.
//  Copyright © 2020 Lucky. All rights reserved.
//

import Foundation
import Alamofire

class DataAPI: BaseAPI{
    public static let shared = DataAPI()
    
    func getDashboard(onSuccess: @escaping(_ data: Dashboard?) -> Void, onError: @escaping(_ errorMessage: String?) -> Void){

        getRequest(url: "partner-dashboard.php", param: nil) { (response: Dashboard) in
            if(response.success == 1){
                onSuccess(response)
            }else{
                onError(response.message)
            }
        } onError: { (error) in
            onError(error?.message?[0] ?? "")
        }
    }
    
    func getSnapshot(onSuccess: @escaping(_ data: Snapshot?) -> Void, onError: @escaping(_ errorMessage: String?) -> Void){

        getRequest(url: "partner-snapshot.php", param: nil) { (response: Snapshot) in
            if(response.success == 1){
                onSuccess(response)
            }else{
                onError(response.message)
            }
        } onError: { (error) in
            onError(error?.message?[0] ?? "")
        }
    }
    
    func getDailyPerformance(onSuccess: @escaping(_ data: DailyPerformance?) -> Void, onError: @escaping(_ errorMessage: String?) -> Void){

        getRequest(url: "daily-performance.php", param: nil) { (response: DailyPerformance) in
            if(response.success == 1){
                onSuccess(response)
            }else{
                onError(response.message)
            }
        } onError: { (error) in
            onError(error?.message?[0] ?? "")
        }
    }
}
