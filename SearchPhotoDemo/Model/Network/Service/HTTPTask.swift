//
//  HTTPTask.swift
//  NetworkLayer
//
//  Created by SuJustin on 2019/12/6.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]
enum HTTPTask{
    case request
    
    /// Use Dictionary encode/decode (body)
    case requestParameters(bodyParameters: Parameters?, urlParameters: URLParameters?)
//    /// Use Dictionary encode/decode (body)
//    case requestParameters(bodyParameters: Parameters? , urlParameters: URLParameters?, additionHeaders: HTTPHeaders?)
//
//    /// Use Format encode/decode (body)
//    case requestParameters(bodyParameters: Parameters? , urlParameters: URLParameters?, additionHeaders: HTTPHeaders?, dataParameters: Parameters?)
//
//    /// Use Json encode/decode (body)
//    case requestCodable(bodyParameters: EncodableParameters?, urlParameters: URLParameters?)
//    /// Use Json encode/decode (body)
//    case requestCodable(bodyParameters: EncodableParameters? , urlParameters: URLParameters?, additionHeaders: HTTPHeaders?)
//
//    /// Use String encode/decode (body)
//    case requestString(bodyParameters: StringParameters?, urlParameters: URLParameters?)
//    /// Use String encode/decode (body)
//    case requestString(bodyParameters: StringParameters? , urlParameters: URLParameters?, additionHeaders: HTTPHeaders?)
//    
}
