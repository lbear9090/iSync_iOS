//
//  AuthError.swift
//  iSync
//
//  Created by Lucky on 11/18/20.
//  Copyright © 2020 Lucky. All rights reserved.
//

import Foundation

struct APIError : Decodable{
    var status: Int?
    var error: String?
    var message: [String]?
}

struct StatusResponse: Decodable{
    var status: Int?
}
