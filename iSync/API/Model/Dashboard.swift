//
//  Dashboard.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import Foundation

struct Dashboard : Codable{
    var success : Int
    var status: Int?
    var message: String?
    var sales: Sales
    var finance_data: Finance
    var total_proposal_sent: Int
}

struct Sales : Codable{
    var daily_sales: String
    var last_weekly_sales: String
    var monthly_sales: String
    var year_to_date_sales: String
}

struct Finance : Codable {
    var sale_revenue: Double
    var refund_revenue: Double
    var net_revenue: Double
    var payment: Double
}
