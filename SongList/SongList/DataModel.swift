//
//  SongListModel.swift
//  SongList
//
//  Created by 강희선 on 2021/11/20.
//

import UIKit


struct DataModel: Codable{
    let trackCount: Int
    let tracks: [Track]
    
    enum CodingKeys: String, CodingKey{
        case trackCount = "resultCount"
        case tracks = "results"
    }
}


struct Track: Codable{
    let title: String
    let artistName: String
    let thumbnailPath: String
    
    enum CodingKeys: String, CodingKey{
        case title = "trackName"
        case artistName
        case thumbnailPath = "artworkUrl30"
    }
}
