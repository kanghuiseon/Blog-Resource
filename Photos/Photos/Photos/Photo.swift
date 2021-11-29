//
//  Photo.swift
//  Photos
//
//  Created by 강희선 on 2021/11/30.
//

import UIKit

class Photo{
    var thumbnail: UIImage?
    let photoID: String
    let farm: Int
    let server: String
    let secret: String
    init(photoID: String, farm: Int, server: String, secret: String){
        self.photoID = photoID
        self.farm = farm
        self.server = server
        self.secret = secret
    }
    func getImageUrl(_ size: String = "m") -> URL?{
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg")
    }
}
