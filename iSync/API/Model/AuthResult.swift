//
//  AuthUser.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import Foundation

struct AuthResult : Codable{
    var success : Int
    var status: Int?
    var message: String
    var token: String?
}
