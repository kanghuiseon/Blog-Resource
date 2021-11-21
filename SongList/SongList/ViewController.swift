//
//  ViewController.swift
//  SongList
//
//  Created by 강희선 on 2021/11/20.
//

import UIKit

class ViewController: UIViewController {
    var tracks: [Track] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(#function)
        getSongList { tracks in
            self.tracks = tracks
        }
    }

    func getSongList(_ completion: @escaping ([Track])->Void){
//        print(#function)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")
        let mediaQuery = URLQueryItem(name: "media", value: "music")
        let entityQuery = URLQueryItem(name: "entity", value: "song")
        let termQuery = URLQueryItem(name: "term", value: "Gdragon")
        urlComponents?.queryItems?.append(mediaQuery)
        urlComponents?.queryItems?.append(entityQuery)
        urlComponents?.queryItems?.append(termQuery)
        let requestURL = urlComponents?.url
        let dataTask = session.dataTask(with: requestURL!) { data, response, error in
            guard error == nil else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200..<300
            guard successRange.contains(statusCode) else {
                print("error http ---> \(error?.localizedDescription)")
                return
            }
            guard let resultData = data else { return }
            let resultString = String(data: resultData, encoding: .utf8)
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(DataModel.self, from: resultData)
                completion(response.tracks)
            }catch{
                print("---> error: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    func pathToImage(_ path: String) -> UIImage{
        let url = URL(string: path)
        var image: UIImage?
        do{
            let data = try Data(contentsOf: url!)
            image = UIImage(data: data)
        }catch{
            print("fail to get data from url bacause ----> \(error.localizedDescription)")
        }
        return image ?? UIImage()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sleep(1)
//        print(#function)
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongCell else { return UITableViewCell() }
        cell.title.text = tracks[indexPath.row].title
        cell.artistName.text = tracks[indexPath.row].artistName
        cell.songImageView.image = pathToImage(tracks[indexPath.row].thumbnailPath)
        return cell
    }
}


extension ViewController: UITableViewDelegate{
    
}
