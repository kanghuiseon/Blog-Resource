//
//  Photo.swift
//  Photos
//
//  Created by 강희선 on 2021/11/29.
//

import UIKit
let apiKey = "18e4f001cd7a11f76979fff572b256d6"
class PhotoViewModel{
    static let shared = PhotoViewModel()
    var photos: [Photo] = []
    func search(searchTerm: String, completion: @escaping ([Photo])-> Void){
        guard let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(searchTerm)&per_page=20&format=json&nojsoncallback=1") else {
            print("invalid url")
            return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("error --> \(String(describing: error?.localizedDescription))")
                return
            }
            guard (response as? HTTPURLResponse) != nil, let data = data else { return }
            do{
                guard let resultDict = try JSONSerialization.jsonObject(with: data) as? [String:AnyObject] else { return }
                guard let photosContainer = resultDict["photos"] as? [String: AnyObject],
                      let photosReceived = photosContainer["photo"] as? [[String: AnyObject]] else { return }

                let photos = self.getPhotos(data: photosReceived)
                completion(photos)
            }catch{
                print("error ---> \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getPhotos(data: [[String: AnyObject]]) -> [Photo]{
        let photos: [Photo] = data.compactMap { photoObj in
            guard let photoID = photoObj["id"] as? String, let farm = photoObj["farm"] as? Int ,let server = photoObj["server"] as? String ,let secret = photoObj["secret"] as? String else { return nil }
            let photo = Photo(photoID: photoID, farm: farm, server: server, secret: secret)
            guard let url = photo.getImageUrl(), let imageData = try? Data(contentsOf: url as URL) else {
                print("cannot get photos")
                return nil }
            guard let image = UIImage(data: imageData) else { return nil }
            photo.thumbnail = image
            return photo
        }
        return photos
    }

}
