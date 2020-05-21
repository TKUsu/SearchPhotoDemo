//
//  Parameters.swift
//  NetworkLayer
//
//  Created by SuJustin on 2019/12/6.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

let CONTENTTYPE = "Content-Type"
let APPLICATION_URL = "application/x-www-form-urlencoded; charset=utf-8"
let APPLICATION_JSON = "application/json"

typealias Parameters = [String: Any]
extension Parameters{
    static let boundary: String = "Boundary+\(arc4random())\(arc4random())"
}
typealias StringParameters = String
typealias URLParameters = [String: String]
typealias EncodableParameters = Encodable

enum CodingErr: String, Error{
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case decodingFailed = "Parameter decoding failed."
    case xmlDecodingFailed = "XML decoding failed."
    case missingURL = "URL is nil."
}

/// 為參數進行編碼，有錯誤將拋出。
protocol ParameterEncoder{
    static func encode(urlRequest: inout URLRequest, with paramaters: URLParameters) throws
    static func encode(urlRequest: inout URLRequest, with paramaters: Parameters, dataParmaters: Parameters) throws
    static func encode(urlRequest: inout URLRequest, with Codable: EncodableParameters) throws
    static func encode(urlRequest: inout URLRequest, with string: StringParameters, encoding: String.Encoding) throws
}
extension ParameterEncoder{
    static func encode(urlRequest: inout URLRequest, with parmaters: URLParameters) throws { fatalError("[Error] Encoding is empty.") }
    static func encode(urlRequest: inout URLRequest, with parmaters: Parameters, dataParmaters: Parameters) throws{ fatalError("[Error] Encoding is empty.") }
    static func encode(urlRequest: inout URLRequest, with Codable: EncodableParameters) throws { fatalError("[Error] Encoding is empty.") }
    static func encode(urlRequest: inout URLRequest, with string: StringParameters, encoding: String.Encoding) throws { fatalError("[Error] Encoding is empty.") }
}
