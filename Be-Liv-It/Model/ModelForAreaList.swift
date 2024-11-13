//
//  ModelForAreaList.swift
//  Be-Liv-It
//
//  Created by mac on 11/01/23.
//

import Foundation

struct AreaListDetails : Codable {
    let result : [ResAreaList]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResAreaList].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct ResAreaList : Codable {
    let id : String?
    let department_id : String?
    let name : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case department_id = "department_id"
        case name = "name"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        department_id = try values.decodeIfPresent(String.self, forKey: .department_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}

