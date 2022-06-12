//
//  NetworkServiceConstant.swift
//  News_NyTimes
//
//  Created by Saurabh D on 11/06/22.
//

import Foundation

struct NetworkServiceConstant {
    static let protcol = "https://"
    static let domain = "api.nytimes.com/svc"
    static let apiVersion  = "/v2/"
    static let viewed = "viewed/"
    //static let noOfDaysData
    static let type = ".json?"
    static let apiKey = "api-key="
    static let authKey = "UJxyVWuzYNH2A4TAlZXG6TyS4EhSudDn"
}

enum NewsEndPointType:String{
    case mostPopular = "/mostpopular"
    case image
}

enum NewsHTTPMethod :String{
    case post = "POST"
    case get = "GET"
}
