//
//  MediaPlayer.swift
//  playMp304
//
//  Created by hoang the anh on 28/04/2022.
//

import Foundation
import AVKit
import UIKit
final class MediaPlayer:UIView {
    
    var album:Album
    
    private lazy var albumName:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .darkGray
        v.textAlignment = .center
        v.font = .systemFont(ofSize: 32, weight: .bold)
        return v
    }()
    private lazy var albumCover: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        v.layer.cornerRadius = 100
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        return v
    }()
    private lazy var progressBar:UISlider = {
        let v = UISlider()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(self, action: #selector(progressScrubbed(_:)), for: .valueChanged)
        v.setThumbImage(UIImage(named: "icons8-car-48"), for: .normal)
        v.maximumTrackTintColor = UIColor(named: "subTitleColor")
        return v
    }()
    
    private lazy var volumeIcon:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints  = false
        v.setImage(UIImage(named: "icons8-low-volume-24"), for: .normal)
        v.addTarget(self, action: #selector(didTapVolumeIcon(_:)), for: .touchUpInside)
        v.tag = 0
        return v
    }()
    
    private lazy var volumeSlide:UISlider = {
        let v = UISlider()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.maximumTrackTintColor = UIColor(named: "subTitleColor")
        v.setThumbImage(UIImage(named: "icons8-rounded-rectangle-stroked-48"), for: .normal)
        v.value = 1
        v.addTarget(self, action: #selector(volumeValue(_:)), for: .valueChanged)
        return v
    }()
   
    private lazy var repeatRandomButton:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setImage(UIImage(named: "icons8-repeat-60"), for: .normal)
        v.addTarget(self, action: #selector(didTapRepeatButton(_:)), for: .touchUpInside)
        v.tag = 0
        return v
    }()
   
    private lazy var elapsedTimeLable:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        //v.textColor = .darkGray
        v.font = .systemFont(ofSize: 14, weight: .light)
        v.text = "00:00"
        return v
    }()
    private lazy var remainingTimeLable:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        //v.textColor = .darkGray
        v.font = .systemFont(ofSize: 14, weight: .light)
        v.text = "00:00"
        return v
    }()
    
    private lazy var songNameLable:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        //v.textColor = .darkGray
        v.font = .systemFont(ofSize: 16, weight: .bold)
        return v
    }()
    private lazy var artistLable:UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        //v.textColor = .darkGray
        v.font = .systemFont(ofSize: 16, weight: .light)
        return v
    }()
    private lazy var previousButton:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints  = false
        let config = UIImage.SymbolConfiguration(pointSize: 10)
        v.setImage(UIImage(named: "icons8-rewind-96", in: nil, with: config), for: .normal)
        v.addTarget(self, action: #selector(didTapPrevious(_:)), for: .touchUpInside)
        return v
    }()
    
    private lazy var playPauseButton:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints  = false
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        v.setImage(UIImage(named: "icons8-circled-play-96", in: nil, with: config), for: .normal)
        v.addTarget(self, action: #selector(didTapPlayPause(_:)), for: .touchUpInside)
        return v
    }()
    
    private lazy var nextButton:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints  = false
        let config = UIImage.SymbolConfiguration(pointSize: 10)
        v.setImage(UIImage(named: "icons8-fast-forward-96", in: nil, with: config), for: .normal)
        v.addTarget(self, action: #selector(didTapNext(_:)), for: .touchUpInside)
        return v
    }()
    
    private lazy var controllStack:UIStackView = {
        let v = UIStackView(arrangedSubviews: [previousButton, playPauseButton, nextButton])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        v.distribution = .equalSpacing
        v.spacing = 10
        return v
    }()
    
    //player
    private var player = AVAudioPlayer()
    private var timer:Timer?
    var playingIndex :Int = 0
    
    init(album:Album) {
        self.album = album
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setupView() {
        albumName.text = album.name
        albumCover.image = album.image
        setupPlayer(song: album.songs[playingIndex])
        
        [albumName, songNameLable, artistLable, elapsedTimeLable, remainingTimeLable].forEach { v in
            v.textColor = .white
        }
        [albumName, albumCover, songNameLable, artistLable, volumeSlide, volumeIcon, repeatRandomButton, progressBar, elapsedTimeLable, remainingTimeLable, controllStack].forEach { v in
            addSubview(v)
        }
        
        setupConstrains()
    }
    private func setupConstrains() {
        //album name
        NSLayoutConstraint.activate([
            albumName.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumName.trailingAnchor.constraint(equalTo: trailingAnchor),
            albumName.topAnchor.constraint(equalTo: topAnchor, constant: 50)])
        //album cover
        NSLayoutConstraint.activate([
            albumCover.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            albumCover.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            albumCover.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 32),
            albumCover.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.5)
        ])
        //song name
        NSLayoutConstraint.activate([
            songNameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            songNameLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            songNameLable.topAnchor.constraint(equalTo: albumCover.bottomAnchor, constant: 16)
        ])
        //artist lable
        NSLayoutConstraint.activate([
            artistLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            artistLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            artistLable.topAnchor.constraint(equalTo: songNameLable.bottomAnchor, constant: 8)
        ])
        //progressBar
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            progressBar.topAnchor.constraint(equalTo: artistLable.bottomAnchor, constant: 8)
        ])
        //volume slider
        NSLayoutConstraint.activate([
            volumeSlide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            volumeSlide.topAnchor.constraint(equalTo: songNameLable.bottomAnchor, constant: 9),
            volumeSlide.widthAnchor.constraint(equalToConstant: 80)
        ])
        // volume icon
        NSLayoutConstraint.activate([
            volumeIcon.trailingAnchor.constraint(equalTo: volumeSlide.leadingAnchor, constant: -1),
            volumeIcon.topAnchor.constraint(equalTo: songNameLable.bottomAnchor, constant: 13)
        ])
       // repeat random button
        NSLayoutConstraint.activate([
            repeatRandomButton.trailingAnchor.constraint(equalTo: volumeIcon.leadingAnchor, constant: -18),
            repeatRandomButton.topAnchor.constraint(equalTo: songNameLable.bottomAnchor, constant: 14)
        ])
        //elapsed time
        NSLayoutConstraint.activate([
            elapsedTimeLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            elapsedTimeLable.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 3)
        ])
        //remaining time
        NSLayoutConstraint.activate([
            remainingTimeLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            remainingTimeLable.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 3)
        ])
        //controll stack
        NSLayoutConstraint.activate([
            controllStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            controllStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            controllStack.topAnchor.constraint(equalTo: remainingTimeLable.bottomAnchor, constant: 8)
        ])
    }
    private func setupPlayer(song:Song) {
        
        guard let url = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else {return}
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
        songNameLable.text = song.name
        artistLable.text = song.artist
        
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            player.prepareToPlay()
            
            
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch {
            
        }
    }
    //player
    func play() {
        progressBar.value = 0
        progressBar.maximumValue = Float(player.duration)
        player.play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
        if volumeSlide.isHidden {
            player.volume = 0
        }else {
            player.volume = volumeSlide.value
        }
    }
    func stop() {
        player.stop()
        timer?.invalidate()
        timer = nil
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    private func setPlayPauseIcon(isPlaying:Bool) {
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        playPauseButton.setImage(UIImage(named: isPlaying ? "icons8-pause-button-96" : "icons8-circled-play-96", in: nil, with: config), for: .normal)
    }
    //objc function
    @objc private func updateProgress() {
        progressBar.value = Float(player.currentTime)
        elapsedTimeLable.text = getFormattedTime(timeInterval: player.currentTime)
        let remainingTime = player.duration - player.currentTime
        remainingTimeLable.text = getFormattedTime(timeInterval: remainingTime)
        
    }
    
    @objc private func progressScrubbed(_ sender: UISlider) {
        player.stop()
        player.currentTime = Float64(sender.value)
        player.play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    @objc private func volumeValue(_ sender:UISlider) {
        player.volume = volumeSlide.value
    }
    @objc private func didTapVolumeIcon(_ sender:UIButton) {
        if volumeIcon.tag == 0 {
            volumeIcon.tag = 1
            volumeIcon.setImage(UIImage(named: "icons8-mute-24"), for: .normal)
            player.volume = 0
            volumeSlide.isHidden = true
        }else if volumeIcon.tag == 1 {
            volumeIcon.tag = 0
            volumeIcon.setImage(UIImage(named: "icons8-low-volume-24"), for: .normal)
            player.volume = volumeSlide.value
            volumeSlide.isHidden = false
        }
    }
    @objc private func didTapRepeatButton(_ sender:UIButton) {
        if repeatRandomButton.tag == 0 {
            repeatRandomButton.tag = 1
            repeatRandomButton.setImage(UIImage(named: "icons8-repeat-one-60 (1)"), for: .normal)
        }else if repeatRandomButton.tag == 1 {
            repeatRandomButton.tag = 2
            repeatRandomButton.setImage(UIImage(named: "icons8-shuffle-48"), for: .normal)
        }else if repeatRandomButton.tag == 2 {
            repeatRandomButton.tag = 0
            repeatRandomButton.setImage(UIImage(named: "icons8-repeat-60"), for: .normal)
        }
    }
    
    
    @objc private func didTapPrevious(_ sender:UIButton) {
        playingIndex -= 1
        if playingIndex < 0 {
            playingIndex = album.songs.count - 1
        }
        setupPlayer(song: album.songs[playingIndex])
        play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    @objc private func didTapPlayPause(_ sender:UIButton) {
        if player.isPlaying {
            player.pause()
        }else {
            player.play()
        }
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    @objc private func didTapNext(_ sender:UIButton) {
        playingIndex += 1
        if playingIndex >= album.songs.count {
            playingIndex = 0
        }
        setupPlayer(song: album.songs[playingIndex])
        play()
        setPlayPauseIcon(isPlaying: player.isPlaying)

    }
    
    //format time
    private func getFormattedTime(timeInterval: TimeInterval) -> String {
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        guard let minsString = timeFormatter.string(from: NSNumber(value: mins)), let secsStr = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "00:00"
        }
        return "\(minsString):\(secsStr)"
    }
}

extension MediaPlayer:AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if repeatRandomButton.tag == 0 {
        didTapNext(nextButton)
        }else if repeatRandomButton.tag == 1 {
            playingIndex += 0
            setupPlayer(song: album.songs[playingIndex])
            play()
        } else if repeatRandomButton.tag == 2 {
            let v = Int.random(in: 0...(album.songs.count - 1))
            playingIndex = v
            setupPlayer(song: album.songs[playingIndex])
            play()
        }
    }
}
