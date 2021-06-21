//
//  AuthUser.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import Foundation

struct Snapshot : Codable{
    var success : Int
    var status: Int?
    var message: String?
    var snapshot: SnapshotData
}

struct SnapshotData : Codable{
    var labels: [String]
    var data: [Int]
}

