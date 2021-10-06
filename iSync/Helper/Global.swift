//
//  Global.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import Foundation
import UIKit

let g_sizeScreen = UIScreen.main.bounds
let kNLogin = Notification.Name("kNLogin")
let baseURL = "https://isync.com/VA/api/"
var g_token : String?
var g_user: User?
var g_emails : [EmailTemplateData]?
