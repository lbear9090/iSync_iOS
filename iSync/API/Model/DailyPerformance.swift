//
//  AuthUser.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import Foundation

struct DailyPerformance : Codable{
    var success : Int
    var status: Int?
    var message: String?
    var daily_performance_by_partner: DailyPerformanceByPartner
}

struct DailyPerformanceByPartner : Codable{
    var data : [DailyPerformanceData]
    var total_clicks: Int
    var total_netsales: Int
    var total_partner_revenue: Double
    var total_your_revenue: Double
}

struct DailyPerformanceData : Codable{
    var date: String
    var affiliate_id: String
    var clicks: Int
    var units_sold: Int
    var partner_revenue: Double
    var your_revenue: Double
}
