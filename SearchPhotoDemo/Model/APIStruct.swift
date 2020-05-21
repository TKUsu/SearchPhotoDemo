//
//  Flickr.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import Foundation

struct Search {
    struct Response: Codable {
        let photos: Photos
    }
}
struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [Photo]
}
struct Photo: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    private let ispublic: Int
    var isPublic: Bool{
        return ispublic != 0
    }
    private let isfriend: Int
    var isFriend: Bool{
        return isfriend != 0
    }
    private let isfamily: Int
    var isFamily: Bool{
        return isfamily != 0
    }
    
    var imageURL: String {
       return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg"
    }
}


struct StateError: Codable {
    let stat: String //fail
    let code: Int
    let message: String
}
enum APIError: Int, Error{
    case UserNotFound = 1
    case InvalidAPIKey = 100
    //    The API key passed was not valid or has expired.
    case ServiceCurrentlyUnavailable = 105
    //    The requested service is temporarily unavailable.
    case WriteOperationFailed = 106
    //    The requested operation failed due to a temporary issue.
    case FormatNotFound = 111
    //    The requested response format was not found.
    case MethodNotFound = 112
    //    The requested method was not found.
    case InvalidSOAPEnvelope = 114
    //    The SOAP envelope send in the request could not be parsed.
    case Invalid_XML_RPC_MethodCall = 115
    //    The XML-RPC request document could not be parsed.
    case BadURLFound = 116
    //    One or more arguments contained a URL that has been used for abuse on Flickr.
}
enum APIMessageError: Error{
    case message(msg: String)
}
