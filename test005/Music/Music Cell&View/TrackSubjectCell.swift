//
//  TrackCell.swift
//  playMp3Url001
//
//  Created by hoang the anh on 01/06/2022.
//

import UIKit

class TrackSubjectCell: UITableViewCell {
    
    @IBOutlet weak var imageTrack: UIImageView!
    
    
    @IBOutlet weak var nameTrack: UILabel!
    
    @IBOutlet weak var artistTrack: UILabel!
    
    @IBOutlet weak var collectionTrack: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getTrack(_ data: TrackModel) {
        let url = URL(string: data.artworkUrl100!)
        imageTrack.sd_setImage(with: url, completed: nil)
        nameTrack.text = data.trackName ?? data.artistName
        artistTrack.text = data.artistName
        collectionTrack.text = data.collectionName
    }
}
