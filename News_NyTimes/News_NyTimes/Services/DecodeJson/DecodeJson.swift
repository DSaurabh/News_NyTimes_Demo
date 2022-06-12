//
//  DecodeJson.swift
//  News_NyTimes
//
//  Created by Saurabh D on 11/06/22.
//

import Foundation

enum DecodeClassType{
    case mostPopular
}

class DecodeJson{
    
    func decodeFrom(data:Data,modelClass: DecodeClassType)->AnyObject?
    {
        let decoder = JSONDecoder()
        
        do
        {
            switch(modelClass){
            case .mostPopular:
                let mostPopular = try decoder.decode(MostPopular.self, from: data)
                return mostPopular as AnyObject
            }
        }catch{
            print(error)
            return nil
        }
    }
}
