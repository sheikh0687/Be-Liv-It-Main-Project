//
//  NetworkManeger.swift
//  Be-Liv-It
//
//  Created by mac on 17/01/23.
//

import UIKit
import Alamofire
import Foundation

class NetworkManger {
    
    static let shared = NetworkManger()
    
    private init() {
        
    }
    
    var arrUploadImage: ResUploadImage?
    
    func uploadImageAndData(_ params:[String: String], _ arrOfImages: [[Int:UIImage]],completionHandler: @escaping(Bool) -> Void) {
        let URL = "https://techimmense.in/BE-LIV-IT-CLOUD/webservice/submit_answer?"
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (indexx, val) in arrOfImages.enumerated() {
                let imag = val[indexx]
                if let imageAr = imag {
                    if let imageData = imageAr.jpegData(compressionQuality: 0.6) {
                        multipartFormData.append(imageData, withName: "file", fileName: "swift_file.png", mimeType: "image/png")
                    }
                }
            }
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: [:]).response{ response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(UploadingImage.self, from: responseData)
                    print(root)
                    if let loginStatus = root.status {
                        if loginStatus == "1" {
                            completionHandler(true)
                        } else {
                            completionHandler(false)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                    completionHandler(false)
                }
            }
        }
    }
}

