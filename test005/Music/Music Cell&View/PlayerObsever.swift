//
//  PlayerObsever.swift
//  test005
//
//  Created by hoang the anh on 16/02/2023.
//

import Foundation



protocol PlayerObserver: class {
    func player(_ player: Player, stateDidChange state: State)
    
    func player(_ player: Player, metadataDidChange from: TrackModel?, to: TrackModel?)
    func playbackItemDidUpdate(player: Player)
    func playingTracksOrderDidChange(player: Player)
    func player(_ player: Player, shuffleModeDidChange state: ShuffleMode)
    func player(_ player: Player, repeatModeDidChange state: RepeatMode)
}

extension PlayerObserver {
    func playbackItemDidUpdate(player: Player) {}
    func playingTracksOrderDidChange(player: Player) {}
    func player(_ player: Player, shuffleModeDidChange state: ShuffleMode) {}
    func player(_ player: Player, repeatModeDidChange state: RepeatMode) {}
}
