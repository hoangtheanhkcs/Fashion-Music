//
//  Album.swift
//  playMp304
//
//  Created by hoang the anh on 27/04/2022.
//

import Foundation
import UIKit

struct Album {
    var name:String
    var image:UIImage
    var songs:[Song]
}

struct Song {
    var name:String
    var image:UIImage
    var artist:String
    var fileName:String
}

extension Album {
    static func get() -> [Album] {
        
        return [
            Album(name: "Acoustic", image: UIImage(named: "acoustic")!, songs: [Song(name: "Happiness", image: UIImage(named: "happiness-2.jpg")!, artist: "bendSound", fileName: "bensound-happiness"), Song(name: "AcousticBreeze", image: UIImage(named: "acousticbreeze.jpg")!, artist: "bendSound", fileName: "bensound-acousticbreeze"), Song(name: "Sweet", image: UIImage(named: "sweet.jpg")!, artist: "bendSound", fileName: "bensound-sweet"), Song(name: "A day to remember", image: UIImage(named: "adaytoremember.jpg")!, artist: "bendSound", fileName: "bensound-adaytoremember"), Song(name: "Cute", image: UIImage(named: "cute.jpg")!, artist: "bendSound", fileName: "bensound-cute"), Song(name: "Sunny", image: UIImage(named: "sunny.jpg")!, artist: "bendSound", fileName: "bensound-sunny"), Song(name: "Buddy", image: UIImage(named: "buddy.jpg")!, artist: "bendSound", fileName: "bensound-buddy"), Song(name: "Ukulele", image: UIImage(named: "ukulele.jpg")!, artist: "bendSound", fileName: "bensound-ukulele"), Song(name: "Tenderness", image: UIImage(named: "tenderness.jpg")!, artist: "bendSound", fileName: "bensound-tenderness")]),
            Album(name: "Cinematic", image: UIImage(named: "cinematic")!, songs: [Song(name: "Betterdays", image: UIImage(named: "betterdays.jpg")!, artist: "bendSound", fileName: "bensound-betterdays"), Song(name: "Adventure", image: UIImage(named: "adventure.jpg")!, artist: "bendSound", fileName: "bensound-adventure"), Song(name: "Epic", image: UIImage(named: "epic.jpg")!, artist: "bendSound", fileName: "bensound-epic"), Song(name: "Onceagain", image: UIImage(named: "onceagain.jpg")!, artist: "bendSound", fileName: "bensound-onceagain"), Song(name: "Slowmotion", image: UIImage(named: "slowmotion-2.jpg")!, artist: "bendSound", fileName: "bensound-slowmotion"), Song(name: "Tomorrow", image: UIImage(named: "tomorrow.jpg")!, artist: "bendSound", fileName: "bensound-tomorrow"), Song(name: "Memories", image: UIImage(named: "memories.jpg")!, artist: "bendSound", fileName: "bensound-memories")]),
            Album(name: "Jazz", image: UIImage(named: "jazz")!, songs: [Song(name: "Hipjazz", image: UIImage(named: "hipjazz.jpg")!, artist: "bendSound", fileName: "bensound-hipjazz"), Song(name: "The jazz piano", image: UIImage(named: "thejazzpiano.jpg")!, artist: "bendSound", fileName: "bensound-thejazzpiano"), Song(name: "All that", image: UIImage(named: "allthat-2.jpg")!, artist: "bendSound", fileName: "bensound-allthat"), Song(name: "Theelevatorbossanova", image: UIImage(named: "theelevatorbossanova.jpg")!, artist: "bendSound", fileName: "bensound-theelevatorbossanova"), Song(name: "Love", image: UIImage(named: "love.jpg")!, artist: "bendSound", fileName: "bensound-love"), Song(name: "Romantic", image: UIImage(named: "romantic.jpg")!, artist: "bendSound", fileName: "bensound-romantic"), Song(name: "JazzComdy", image: UIImage(named: "jazzcomedy.jpg")!, artist: "bendSound", fileName: "bensound-jazzcomedy"), Song(name: "JazzFrenchy", image: UIImage(named: "jazzyfrenchy.jpg")!, artist: "bendSound", fileName: "bensound-jazzyfrenchy"), Song(name: "The Lounge", image: UIImage(named: "thelounge.jpg")!, artist: "bendSound", fileName: "bensound-thelounge")])
        ]
    }
    
    
}
