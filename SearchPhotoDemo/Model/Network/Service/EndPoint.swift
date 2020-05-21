//
//  EndPointType.swift
//  NetworkLayer
//
//  Created by SuJustin on 2019/12/6.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

/// 基本上它是一個 URLRequest 參數，擁有所有構組元件如標頭 (Header)、查詢參數 (Query Parameters)、本體參數 (Body Parameters) 等 。
protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
