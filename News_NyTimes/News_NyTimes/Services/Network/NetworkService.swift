//
//  NetworkService.swift
//  News_NyTimes
//
//  Created by Saurabh D on 11/06/22.
//

import Foundation

enum NetworkServiceResponse {
    case notValidURL
    case success(response: Data)
    case failure
    case notConnectedToInternet
}

class NetworkService{
    
    func makeRequest(endPoint: NewsEndPointType,
                     method: NewsHTTPMethod = .get,
                     headers: Dictionary<String,String>? = [:],
                     params: Dictionary<String,String>? = [:],
                     durationInDays:Int,
                     completion: @escaping (NetworkServiceResponse) -> Void){
        
        let urlString = NetworkService.getRequestURL(newsType: .mostPopular, method: .post, newsDurationInDays: durationInDays)
        let url = URL(string: urlString)
        
        guard let url = url else{ return self.notValidURL(completion: completion) }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let request = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            DispatchQueue.global(qos: .background).async { [weak self] in
                let strongSelf = self
                
                if let response = response as? HTTPURLResponse{
                    if(response.statusCode == NSURLErrorNotConnectedToInternet)
                    {
                        strongSelf?.notConnectedToInternet(completion: completion)
                    }else if (200...299).contains(response.statusCode), data != nil {
                        strongSelf?.success(data: data!, completion: completion)
                    }else{
                        strongSelf?.failure(completion: completion)
                    }
                }
            }
        }
        request.resume()
    }
    
    func makeRequest(url: URL?,
                     method: NewsHTTPMethod = .get,
                     headers: Dictionary<String,String>? = [:],
                     params: Dictionary<String,String>? = [:],
                     completion: @escaping (NetworkServiceResponse) -> Void){
        
        guard let url = url else{ return self.notValidURL(completion: completion) }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let request = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            DispatchQueue.global().async { [weak self] in
                let strongSelf = self
                
                if let response = response as? HTTPURLResponse{
                    if(response.statusCode == NSURLErrorNotConnectedToInternet)
                    {
                        strongSelf?.notConnectedToInternet(completion: completion)
                    }else if (200...299).contains(response.statusCode), data != nil {
                        strongSelf?.success(data: data!, completion: completion)
                    }else{
                        strongSelf?.failure(completion: completion)
                    }
                }
            }
        }
        request.resume()
    }
    
    func notValidURL (completion:@escaping (NetworkServiceResponse) -> Void) {
        completion(.notValidURL)
    }
    func notConnectedToInternet (completion:@escaping (NetworkServiceResponse) -> Void) {
        completion(.notConnectedToInternet)
    }
    
    func failure (completion:@escaping (NetworkServiceResponse) -> Void) {
        completion(.failure)
    }
    
    func success (data: Data, completion:@escaping (NetworkServiceResponse) -> Void) {
        completion(.success(response: data))
    }
    
}
extension NetworkService{
    class func getRequestURL(newsType:NewsEndPointType, method:NewsHTTPMethod ,newsDurationInDays:Int)-> String
    {
        let formaetdURLString = NetworkServiceConstant.protcol + NetworkServiceConstant.domain + newsType.rawValue + NetworkServiceConstant.apiVersion + NetworkServiceConstant.viewed + String(newsDurationInDays) + NetworkServiceConstant.type + NetworkServiceConstant.apiKey + NetworkServiceConstant.authKey
        return formaetdURLString
    }
}
