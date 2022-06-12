//
//  NewsAPI.swift
//  News
//
//  Created by Saurabh D on 11/06/22.
//

import Foundation
import UIKit

enum NewsError: Error {
    case success
    case networkDown
    case failed
}

class NewsAPI
{
    let networkService = NetworkService()
    
    func fetchAllMostPopularArticles(_ completion:@escaping (MostPopular?,NewsError?) -> ())
    {
        networkService.makeRequest(endPoint: .mostPopular,method: .post, durationInDays: 1) { networkServiceResponse in
            
            switch networkServiceResponse {
            case .success(let response):
                let decodeJson = DecodeJson()
                let data =  decodeJson.decodeFrom(data: response, modelClass: .mostPopular)
                
                let  newData = data as? MostPopular
                completion(newData,.success)
            case .failure:
                completion(nil,.failed)
            case .notConnectedToInternet:
                completion(nil,.networkDown)
            case .notValidURL:
                completion(nil,.failed)
            }
        }
    }
    
    func downLoadImageFromUrl(urlPath:String, _ completion:@escaping (UIImage?) -> ())
    {
        let url = URL(string: urlPath)
        networkService.makeRequest(url: url) { networkServiceResponse in
            switch networkServiceResponse {
            case .success(let response):
                completion(UIImage(data: response))
            case .failure:
                completion(nil)
            case .notConnectedToInternet:
                completion(nil)
            case .notValidURL:
                completion(nil)
            }
        }
    }
}
