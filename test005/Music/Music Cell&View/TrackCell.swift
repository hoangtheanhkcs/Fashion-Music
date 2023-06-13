//
//  TrackCell.swift
//  playMp3Url001
//
//  Created by hoang the anh on 15/05/2022.
//

import UIKit
import SDWebImage

class TrackCell: UITableViewCell {
    @IBOutlet weak var trackImgeView: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    
    @IBOutlet weak var trackArtist: UILabel!
    
    @IBOutlet weak var trackCollection: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func getTrack(_ data: TrackModel) {
        let url = URL(string: data.artworkUrl100!)
        trackImgeView.sd_setImage(with: url, completed: nil)
        trackName.text = data.trackName
        trackArtist.text = data.artistName
        trackCollection.text = data.collectionName
    }
    
}
