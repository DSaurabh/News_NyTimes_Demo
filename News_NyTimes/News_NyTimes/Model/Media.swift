//
//  Media.swift
//  News
//
//  Created by Saurabh D on 11/06/22.
//

import Foundation

struct Media: Codable
{
    let approvedForSyndication:Int?
    let caption:String?
    let copyright:String?
    let mediaMetadata:[MediaMetadata]?
    
    enum CodingKeys: String, CodingKey {
        case approvedForSyndication = "approved_for_syndication"
        case caption, copyright
        case mediaMetadata = "media-metadata"
    }
}
