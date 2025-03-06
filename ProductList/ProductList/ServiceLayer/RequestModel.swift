//
//  RequestModel.swift
//  ProductList
//
//  Created by Juan Arbelaez on 5/03/25.
//

import Foundation

struct RequestModel {
    let endpoint: Endpoints
    var queryItems: [String:String]?
    let httpMethod: HttpMethod
    var baseUrl: URLBase = .fakestore
    
    func getURL() -> String{
        return baseUrl.rawValue + endpoint.rawValue
    }
    
    enum HttpMethod: String{
        case GET
        case POST
        case PUT
    }
    
    enum Endpoints: String{
        case products = "/products"
        case productDetail = "/products/"
        case empty = ""
    }
    
    enum URLBase: String{
        case fakestore = "https://fakestoreapi.com"
        
    }
}
