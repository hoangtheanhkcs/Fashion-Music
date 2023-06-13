//
//  Player.swift
//  test005
//
//  Created by hoang the anh on 16/02/2023.
//

import Foundation
import AVKit
enum State {
    case notStarted, fetching, playing, paused
}

enum ShuffleMode: Int {
    case none, active
}

enum RepeatMode: Int {
    case none, repeatAll, repeatOne
}
class Player: Observable {
    static let shared = Player()
    typealias Observer = PlayerObserver
    private (set) var state: State = .notStarted {
        didSet {
            notifyObservers { $0.player(self, stateDidChange: state)
            }
        }
    }
    
}
