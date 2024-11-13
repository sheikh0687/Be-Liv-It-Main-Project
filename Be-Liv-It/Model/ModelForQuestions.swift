//
//  ModelForQuestions.swift
//  Be-Liv-It
//
//  Created by mac on 12/01/23.
//

import Foundation

struct GetQuestionsList : Codable {
    let result : [ResQuestions]?
    let message : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case result = "result"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResQuestions].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}
struct ResQuestions : Codable {
    let id : String?
    let company_id : String?
    let survey_id : String?
    let area_id : String?
    let area_name : String?
    let batch_number : String?
    let question : String?
    let title : String?
    let option_value : String?
    let type : String?
    let date_time : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case company_id = "company_id"
        case survey_id = "survey_id"
        case area_id = "area_id"
        case area_name = "area_name"
        case batch_number = "batch_number"
        case question = "question"
        case title = "Title"
        case option_value = "option_value"
        case type = "type"
        case date_time = "date_time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        company_id = try values.decodeIfPresent(String.self, forKey: .company_id)
        survey_id = try values.decodeIfPresent(String.self, forKey: .survey_id)
        area_id = try values.decodeIfPresent(String.self, forKey: .area_id)
        area_name = try values.decodeIfPresent(String.self, forKey: .area_name)
        batch_number = try values.decodeIfPresent(String.self, forKey: .batch_number)
        question = try values.decodeIfPresent(String.self, forKey: .question)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        option_value = try values.decodeIfPresent(String.self, forKey: .option_value)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
    
}
