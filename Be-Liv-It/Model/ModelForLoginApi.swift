//
//  ModelForLoginApi.swift
//  Be-Liv-It
//
//  Created by mac on 11/01/23.
//

import Foundation

struct UserLoginApi : Codable {
    let result : ResUserLogin?
    let message : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case result = "result"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResUserLogin.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}

struct ResUserLogin : Codable {
    let id : String?
    let company_id : String?
    let company_pin : String?
    let user_name : String?
    let mobile : String?
    let email : String?
    let password : String?
    let image : String?
    let document : String?
    let type : String?
    let cif : String?
    let position : String?
    let direction : String?
    let contact : String?
    let social_id : String?
    let lat : String?
    let lon : String?
    let address : String?
    let register_id : String?
    let ios_register_id : String?
    let status : String?
    let date_time : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case company_id = "company_id"
        case company_pin = "company_pin"
        case user_name = "user_name"
        case mobile = "mobile"
        case email = "email"
        case password = "password"
        case image = "image"
        case document = "document"
        case type = "type"
        case cif = "cif"
        case position = "position"
        case direction = "direction"
        case contact = "contact"
        case social_id = "social_id"
        case lat = "lat"
        case lon = "lon"
        case address = "address"
        case register_id = "register_id"
        case ios_register_id = "ios_register_id"
        case status = "status"
        case date_time = "date_time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        company_id = try values.decodeIfPresent(String.self, forKey: .company_id)
        company_pin = try values.decodeIfPresent(String.self, forKey: .company_pin)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        document = try values.decodeIfPresent(String.self, forKey: .document)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        cif = try values.decodeIfPresent(String.self, forKey: .cif)
        position = try values.decodeIfPresent(String.self, forKey: .position)
        direction = try values.decodeIfPresent(String.self, forKey: .direction)
        contact = try values.decodeIfPresent(String.self, forKey: .contact)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        register_id = try values.decodeIfPresent(String.self, forKey: .register_id)
        ios_register_id = try values.decodeIfPresent(String.self, forKey: .ios_register_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
    
}
