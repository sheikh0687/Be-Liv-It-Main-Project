//
//  ModelForNotification.swift
//  Be-Liv-It
//
//  Created by mac on 12/01/23.
//

import Foundation

struct GetNotification: Codable {
    let result : [ResNotification]?
    let message : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case result = "result"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResNotification].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}
struct ResNotification : Codable {
    let id : String?
    let company_id : String?
    let employee_id : String?
    let title : String?
    let message : String?
    let date_time : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case company_id = "company_id"
        case employee_id = "employee_id"
        case title = "title"
        case message = "message"
        case date_time = "date_time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        company_id = try values.decodeIfPresent(String.self, forKey: .company_id)
        employee_id = try values.decodeIfPresent(String.self, forKey: .employee_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
    
}
