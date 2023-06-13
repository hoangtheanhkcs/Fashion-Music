//
//  SearchAPI.swift
//  playMp3Url001
//
//  Created by hoang the anh on 15/05/2022.
//

import Foundation
import Alamofire

extension MusicViewController01 {
    func getRequest(url:String) {
        let params = ["term": url,
                      "limit": "20",
                      "media": "music"]
        AF.request("https://itunes.apple.com/search", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let data = value as? [String:Any],
                   let dataObject = data["results"] as? [[String:Any]] else {return}
                self.dataTrack.removeAll()
                dataObject.forEach { dataobj in
                    self.dataTrack.append(TrackModel(data: dataobj))
                }
                self.tableView.reloadData()
            case .failure(_):
                print("error")
            }
        }
    }
}
