//
//  FlickrEndPoint.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import Foundation

enum FlickrEndPoint{
    case WS(url: String)
    case WSURLJSON(path: WSJSONMethod, urlParameters: URLParameters)
}
extension FlickrEndPoint: EndPointType{
    var baseURL: URL {
        var urlStr: String = ""
        switch self {
        case .WSURLJSON:
            urlStr = "https://www.flickr.com/services/rest"
        case .WS(let url):
            urlStr = url
        }
        guard let url = URL(string: urlStr) else {
            fatalError("[Warning] baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .WSURLJSON(_ , let urlParameters):
            return .requestParameters(bodyParameters: nil, urlParameters: urlParameters)
        case .WS:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
