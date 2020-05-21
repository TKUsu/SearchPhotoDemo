//
//  NetworkRouter.swift
//  NetworkLayer
//
//  Created by SuJustin on 2019/12/6.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter: AnyObject {
    /// [推斷型態] process any `EndPointType` type.
    /// - haven't `associatedtype`, `EndPointType` need init.
    associatedtype EndPoint: EndPointType
    
    /// Request function at Network
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    /// Request function at Network (Certificate Authentica)
    func request(_ route: EndPoint, SSLEnable: Bool, cerFileName: String, completion: @escaping NetworkRouterCompletion)
    
    /// Request can cancel at any time in self lift cycle.
    func cancel()
}


