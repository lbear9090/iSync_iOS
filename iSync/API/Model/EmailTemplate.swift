//
//  EmailTemplate.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import Foundation

struct EmailTemplate : Codable{
    var success : Int
    var status: Int?
    var message: String?
    var data: [EmailTemplateData]
}

struct EmailTemplateData : Codable{
    var id: String;
    var email_subject: String;
    var email_body: String;
}

struct EmailResult : Codable{
    var success : Int
    var status: Int?
    var message: String?
}

