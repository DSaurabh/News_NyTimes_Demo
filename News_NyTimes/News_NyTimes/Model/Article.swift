//
//  Article.swift
//  News
//
//  Created by Saurabh D on 11/06/22.
//

import Foundation

struct Article: Codable
{
    // the article  image, title, abstract, author and date of the article.
    let abstract:String?
    let type:String?
    let title:String?
    let author:String?
    let updatedDate:String?
    let url:String?
    let media:[Media]?
    
    enum CodingKeys: String, CodingKey {
        case abstract, type, title
        case author = "byline"
        case updatedDate = "updated"
        case url, media
    }
}
