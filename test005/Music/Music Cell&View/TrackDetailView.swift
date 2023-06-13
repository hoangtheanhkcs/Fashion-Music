//
//  TrackDetailView.swift
//  MusicApp
//
//  Created by Zhanibek Lukpanov on 04.11.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

protocol TrackMovingDelegateM: AnyObject {
    func moveBackForPreviousTrackM() -> TrackModel?
    func moveForwardForPreviousTrackM() -> TrackModel?
}

protocol TrackMovingDelegate: AnyObject {
    func moveBackForPreviousTrack() -> TrackModel?
    func moveForwardForPreviousTrack() -> TrackModel?
}

class TrackDetailView: UIView, UITableViewDelegate {

    
    
//    var dataTrack :[TrackModel] = []
    var tagg:Int = 0
    
    // MARK:- IBOutlets
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    // MARK:- IBoutlets for miniMapView
    @IBOutlet weak var miniTackView: UIView!
    @IBOutlet weak var miniGoForwardButton: UIButton!
    @IBOutlet weak var miniImageView: UIImageView!
    @IBOutlet weak var miniTrackTitleLabel: UILabel!
    @IBOutlet weak var miniPlayPauseButton: UIButton!
    
    @IBOutlet weak var maximizedStackView: UIStackView!
    
    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    let player: AVPlayer = {
       let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
       return avPlayer
    }()
    weak var delegateM: TrackMovingDelegateM?
    weak var delegate: TrackMovingDelegate?
    weak var tabBarDelegate: MainTabBarControllerDelegate?
    
    // MARK:- IBActions
    
    @IBAction func dragDownButtonTapped(_ sender: UIButton) {
        
        self.tabBarDelegate?.minizeTrackDetail()
        
//        self.removeFromSuperview()
    }
    
    @IBAction func handleCurrentTimeSlider(_ sender: UISlider) {
        let percentage = currentTimeSlider.value
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        player.seek(to: seekTime)
    }
    
    @IBAction func handleVolumeSlider(_ sender: UISlider) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func previousTrack(_ sender: UIButton) {
        if tagg == 0 {
        let cellViewModel = delegate?.moveBackForPreviousTrack()
        guard let cellInfo = cellViewModel else { return }
        self.set(viewModel: cellInfo)
        }else if tagg == 1 {
        let cellViewModelM = delegateM?.moveBackForPreviousTrackM()
        guard let cellInfoM = cellViewModelM else { return }
        self.set(viewModel: cellInfoM)
        }
        
    }
    
    @IBAction func nextTrack(_ sender: UIButton) {
        if tagg == 0 {
        let cellViewModel = delegate?.moveForwardForPreviousTrack()
        guard let cellInfo = cellViewModel else { return }
        self.set(viewModel: cellInfo)
        }else if tagg == 1 {
        let cellViewModelM = delegateM?.moveForwardForPreviousTrackM()
        guard let cellInfoM = cellViewModelM else { return }
        self.set(viewModel: cellInfoM)
        }
    }
    
    @IBAction func playPauseAction(_ sender: UIButton) {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            miniPlayPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            enlargeTrackImageView()
        } else {
            player.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            miniPlayPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            reduceTrackImageView()
        }
    }
    // MARK:- awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        let scale: CGFloat = 0.7
        trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        trackImageView.layer.cornerRadius = 7
        miniPlayPauseButton.imageEdgeInsets = .init(top: 11, left: 11, bottom: 11, right: 11)
        setupGesture()
        
        
    }
    
    
    
    
    // MARK:- setup TrackDetail
    func set(viewModel: TrackModel) {
        
        miniTrackTitleLabel.text = viewModel.trackName
        trackTitleLabel.text = viewModel.trackName
        authorLabel.text = viewModel.artistName
        playTrack(preview: viewModel.previewUrl)
//        monitorStarTime()
        observeOverlayerCurrentTime()
        playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        let string600 = viewModel.artworkUrl100!.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ) else { return }
        miniImageView.sd_setImage(with: url, completed: nil)
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    func stop() {
        player.replaceCurrentItem(with: nil)
    }
    
    private func setupGesture() {
        miniTackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapMaximized)))
        miniTackView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:))))
        maximizedStackView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismissPan)))
    }
    
    @objc private func handleTapMaximized() {
        self.tabBarDelegate?.maximizeTrackDetail(viewModel: nil)
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("began")
        case .changed:
            handlePanChanged(gesture: gesture)
        case .ended:
            handlePanEnded(gesture: gesture)
        @unknown default:
            print("")
        }
    }
    
    private func handlePanChanged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        let newAlpha = 1 + translation.y / 1200
        self.miniTackView.alpha = newAlpha < 0 ? 0 : newAlpha
        self.maximizedStackView.alpha = -translation.y / 200
    }
    
    private func handlePanEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        let velocity = gesture.velocity(in: self.superview)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.transform = .identity
                        if translation.y < -200 || velocity.y < -500 {
                            self.tabBarDelegate?.maximizeTrackDetail(viewModel: nil)
                        } else {
                            self.miniTackView.alpha = 1
                            self.maximizedStackView.alpha = 0
                        }
                       },
                       completion: nil)
    }
    
    
    @objc private func handleDismissPan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: self.superview)
            maximizedStackView.transform = CGAffineTransform(translationX: 0, y: translation.y)
        case .ended:
            let translation = gesture.translation(in: self.superview)
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                            self.maximizedStackView.transform = .identity
                            if translation.y > 50 {
                                self.tabBarDelegate?.minizeTrackDetail()
                            }
                           },
                           completion: nil)

        @unknown default:
            print("unknown default")
        }
    }
    // MARK:- PLay track func
    private func playTrack(preview: String?) {
        
        guard let url = URL(string: preview ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        
    }
    @objc func playerDidFinishPlaying(sender: Notification) {
        if tagg == 0 {
        let cellViewModel = delegate?.moveForwardForPreviousTrack()
        guard let cellInfo = cellViewModel else { return }
        self.set(viewModel: cellInfo)
        }else if tagg == 1 {
        let cellViewModelM = delegateM?.moveForwardForPreviousTrackM()
        guard let cellInfoM = cellViewModelM else { return }
        self.set(viewModel: cellInfoM)
        }
    }
    
    // MARK:- Animations
    private func enlargeTrackImageView() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: { [weak self] in
                        self?.trackImageView.transform = .identity
                       },
                       completion: nil)
    }
    
    private func reduceTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
            let scale: CGFloat = 0.7
            self?.trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: nil)
    }
    
    // MARK:- Times setup
    private func monitorStarTime() {
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) {[weak self] in
            self?.enlargeTrackImageView()
        }
    }
    
    private func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationSeconds
        self.currentTimeSlider.value = Float(percentage)
        
    }
    
    // MARK:- Observe label current time
    private func observeOverlayerCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 50)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) {[weak self] (time) in
            self?.currentTimeLabel.text = time.toDisplayString()
            
            let durationTime = self?.player.currentItem?.duration
            let currentDurationTimeText = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).toDisplayString()
            self?.durationLabel.text = "-\(currentDurationTimeText)"
            self?.updateCurrentTimeSlider()
            
        }
    }
    
 
}

