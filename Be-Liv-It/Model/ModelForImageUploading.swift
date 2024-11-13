//
//  ModelForImageUploading.swift
//  Be-Liv-It
//
//  Created by mac on 18/01/23.
//

import Foundation

struct  UploadingImage : Codable {
    let result : ResUploadImage?
    let message : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case result = "result"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResUploadImage.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}
struct ResUploadImage : Codable {
    let id : String?
    let user_id : String?
    let que_id : String?
    let answers : String?
    let text_answers : String?
    let area_id : String?
    let area_name : String?
    let batch_number : String?
    let version_number : String?
    let expire_date : String?
    let date_time : String?
    let submit_date : String?
    let status : String?
    let manager_id : String?
    let signout_date : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case que_id = "que_id"
        case answers = "answers"
        case text_answers = "text_answers"
        case area_id = "area_id"
        case area_name = "area_name"
        case batch_number = "batch_number"
        case version_number = "version_number"
        case expire_date = "expire_date"
        case date_time = "date_time"
        case submit_date = "submit_date"
        case status = "status"
        case manager_id = "manager_id"
        case signout_date = "signout_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        que_id = try values.decodeIfPresent(String.self, forKey: .que_id)
        answers = try values.decodeIfPresent(String.self, forKey: .answers)
        text_answers = try values.decodeIfPresent(String.self, forKey: .text_answers)
        area_id = try values.decodeIfPresent(String.self, forKey: .area_id)
        area_name = try values.decodeIfPresent(String.self, forKey: .area_name)
        batch_number = try values.decodeIfPresent(String.self, forKey: .batch_number)
        version_number = try values.decodeIfPresent(String.self, forKey: .version_number)
        expire_date = try values.decodeIfPresent(String.self, forKey: .expire_date)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        submit_date = try values.decodeIfPresent(String.self, forKey: .submit_date)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        manager_id = try values.decodeIfPresent(String.self, forKey: .manager_id)
        signout_date = try values.decodeIfPresent(String.self, forKey: .signout_date)
    }
    
}
