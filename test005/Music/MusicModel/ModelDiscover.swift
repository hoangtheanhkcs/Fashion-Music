//
//  Model.swift
//  playMp3Url001
//
//  Created by hoang the anh on 15/05/2022.
//

import Foundation
import UIKit

struct SubjectResponse: Codable {
    var response: [SubjectType]
}
struct SubjectType: Codable {
    var typemusic:String?
    var datasubject: [SubjectTrack]
}

struct SubjectTrack: Codable {
    var subject:String?
    var subjectImage:String?
    var data: [TrackModel]
}
struct TrackModel :Codable {
    var trackName:String?
    var artistName:String?
    var collectionName:String?
    var artworkUrl100 :String?
    var previewUrl : String?
     
    init(data:[String:Any]) {
        if let trackNameN = data["trackName"] as? String {
            self.trackName = trackNameN
        }else{
            self.trackName = ""
        }
        if let artistNameN = data["artistName"] as? String {
            self.artistName = artistNameN
        }else{
            self.artistName = ""
        }
        if let collectionNameN = data["collectionName"] as? String {
            self.collectionName = collectionNameN
        }else{
            self.collectionName = ""
        }
        if let artworkUrl100N = data["artworkUrl100"] as? String {
            self.artworkUrl100 = artworkUrl100N
        }else{
            self.artworkUrl100 = ""
        }
        if let previewUrlN = data["previewUrl"] as? String {
            self.previewUrl = previewUrlN
        }else{
            self.previewUrl = ""
        }
    }
}
