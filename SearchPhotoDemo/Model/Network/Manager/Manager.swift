//
//  Manager.swift
//  NetworkLayer
//
//  Created by SuJustin on 2019/12/17.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

typealias completionJSON<T: Codable> = (_ response: T?,_ error: Error?)->()
struct NetworkManager{
    static var env: NetworkEnvironment = .demo
    
    let router = Router<FlickrEndPoint>()
    
    private let methodYek = "method"
    
    /// webservice
    ///
    /// - Parameters:
    ///   - path: URL Method
    ///   - urlParameter: set request url parametersd
    ///   - resType: response type (JSON-Structure)
    ///   - completion: handle after get response
    ///   - response: response JSON-Structure
    ///   - error: client. request. decode/encode error
    func requestWSURLJSON<U: Codable> (
            _ path: WSJSONMethod,
            urlParameter: URLParameters,
            resType: U.Type,
            completion: @escaping completionJSON<U> ) {
                var parameters: URLParameters = [methodYek: path.rawValue]
                parameters.merge(urlParameter, uniquingKeysWith: {(_, new) in new} )
                print("[API] Request Data: \(parameters)")
                router.request(.WSURLJSON(path: path, urlParameters: parameters)) { (data, res, error) in
                    do{
                        let data = try self.responseFilter(data, res, error)
                        if let res = U.decode(data: data){
                            print("[API] Response: \(res)")
                            completion(res, nil)
                        }else if let res = StateError.decode(data: data){
                            let error = APIError.init(rawValue: res.code)
                            guard error != nil else{
                                completion(nil, APIMessageError.message(msg: res.message))
                                return
                            }
                            completion(nil, error)
                        }else{
                            throw CodingErr.decodingFailed
                        }
                    }catch{
                        completion(nil, error)
                    }
                }
    }
    
    /// webservice
    ///
    /// - Parameters:
    ///   - path: URL Path
    ///   - bodyParameters: set request body parametersd
    ///   - resType: response type (JSON-Codeable)
    ///   - completion: handle after get response
    ///   - response: response JSON-Codeable
    ///   - error: client. request. decode/encode error
    func request(
            _ url: String,
            completion: @escaping completionJSON<Data>){
                router.request(.WS(url: url)) { (data, res, error) in
                    do{
                        let data = try self.responseFilter(data, res, error)
                        completion(data, nil)
                    }catch{
                        completion(nil, error)
                    }
                }
    }
    
    /// This function handles exception errors
    ///  - Success:
    ///  `data: T?`
    ///  - Error:
    /// ```
    ///  error == nil [ClientError.DataTaskError]
    ///  response == nil || response != HTTPURLResponse [NetworkErr.responseIsNil]
    ///  data == nil [NetworkErr.noData]
    ///  Network.Status(from: res) == .failure(let error) [error]
    /// ```
    private func responseFilter<T>(_ data: T?, _ response: URLResponse?, _ error: Error?) throws -> T {
        guard error == nil else{
            throw ClientError.DataTaskError
        }
        guard let res = response as? HTTPURLResponse else{
            throw NetworkErr.responseIsNil
        }
        let result = Network.Status(from: res)
        switch result{
        case .success(_):
            guard let data = data else{
                throw NetworkErr.noData
            }
            return data
        case .failure(let error):
            throw error
        }
    }
}
