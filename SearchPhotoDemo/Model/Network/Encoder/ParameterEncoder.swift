//
//  URLParameterEncoder.swift
//  NetworkLayer
//
//  Created by SuJustin on 2019/12/6.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder{
    static func encode(urlRequest: inout URLRequest, with parameters: URLParameters) throws {
        guard let url = urlRequest.url else{ throw CodingErr.missingURL }
        // URLComponents:
        // A structure that parses URLs into and constructs URLs from their constituent parts.
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            !parameters.isEmpty {
            // QueryItems:
            // An array of query items for the URL in the order in which they appear in the original query string.
            urlComponents.queryItems = [URLQueryItem]()
            
            for (k, v) in parameters{
                let queryItem = URLQueryItem(name: k, value: "\(v)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
                urlRequest.url = urlComponents.url
            }
        }
    }
}

struct JSONParameterEncoder: ParameterEncoder{
    ///
    /// - encode parameters to data
    /// - set data to http body
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws{
        do{
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
//            if urlRequest.value(forHTTPHeaderField: CONTENTTYPE) == nil{
//                urlRequest.setValue(APPLICATION_JSON, forHTTPHeaderField: CONTENTTYPE)
//            }
        }catch{
            throw CodingErr.encodingFailed
        }
    }
    
    ///
    /// - encode codable to data
    /// - set data to http body
    static func encode(urlRequest: inout URLRequest, with codable: Encodable) throws {
        do {
            let data = try codable.encodeData()
            urlRequest.httpBody = data
//            if urlRequest.value(forHTTPHeaderField: CONTENTTYPE) == nil{
//                urlRequest.setValue(APPLICATION_JSON, forHTTPHeaderField: CONTENTTYPE)
//            }
        } catch {
            throw CodingErr.encodingFailed
        }
    }
}

struct StringParameterEncoder: ParameterEncoder{
    ///
    /// - encode String to data
    /// - set data to http body
    static func encode(urlRequest: inout URLRequest, with string: StringParameters, encoding: String.Encoding = .utf8) throws {
        guard let data = string.data(using: encoding) else{
            throw CodingErr.encodingFailed
        }
        urlRequest.httpBody = data
    }
}

struct FormatParameterEncoder: ParameterEncoder{
    /// - Parameters:
    /// ``` swift
    ///     "--\(boundary)\r\n"
    ///     "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
    ///     "\(value)\r\n"
    /// ```
    /// - DataParameters:
    /// ``` swift
    ///     "--\(boundary)\r\n"
    ///     "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(arc4random())\"\r\n""
    ///     "Content-Type: image/png\r\n\r\n"
    ///     value
    ///     "\r\n"
    /// ```
    /// - End:
    /// ``` swift
    ///     "--\(boundary)--\r\n"
    /// ```
    static func encode(urlRequest: inout URLRequest, with parmaters: Parameters, dataParmaters: Parameters) throws {
        var body = Data()
        let boundary = Parameters.boundary
        
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        for (key, value) in parmaters {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }

        for (key, value) in dataParmaters {
            guard let data = value as? Data else{
                throw CodingErr.encodingFailed
            }
            body.appendString(string: "--\(boundary)\r\n")
            //此處放入file name，以隨機數代替，可自行放入
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(arc4random())\"\r\n")
            //image/png 可改為其他檔案類型 ex: jpeg
            body.appendString(string: "Content-Type: image/png\r\n\r\n")
            body.append(data)
            body.appendString(string: "\r\n")
        }

        body.appendString(string: "--\(boundary)--\r\n")
    }
}
