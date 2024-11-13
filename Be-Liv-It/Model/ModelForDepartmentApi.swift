//
//  ModelForDepartmentApi.swift
//  Be-Liv-It
//
//  Created by mac on 23/01/23.
//

import Foundation

struct DepartmentDetails : Codable {
    let result : [ResDepartmentDetails]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResDepartmentDetails].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
struct ResDepartmentDetails : Codable {
    let id : String?
    let name : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
