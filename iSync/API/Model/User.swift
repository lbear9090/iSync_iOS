//
//  User.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import Foundation

struct UserData : Codable{
    var success : Int
    var status: Int?
    var message: String?
    var user: User
}

struct User : Codable{
    var id: String
    var name: String
    var email: String
}

