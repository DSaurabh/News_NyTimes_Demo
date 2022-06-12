//
//  MostPopularNews.swift
//  News
//
//  Created by Saurabh D on 11/06/22.
//

import Foundation

struct MostPopular: Codable
{
    let copyright:String?
    let numResults:Int?
    let status :String?
    let articles:[Article]?
    
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case articles = "results"
    }
}
