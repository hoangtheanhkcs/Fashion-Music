//
//  MusicPlayerViewController.swift
//  playMp304
//
//  Created by hoang the anh on 28/04/2022.
//

import Foundation
import UIKit

final class RadioMusicPlayerViewController: UIViewController {
    var album:Album
    
    private lazy var mediaPlayer:MediaPlayer = {
        let v = MediaPlayer(album: album)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var backToAlbum:UIButton = {
       let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setImage(UIImage(named: "icons8-back-48"), for: .normal)
        v.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
        return v
    }()
    private lazy var goToPlayList:UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setImage(UIImage(named: "icons8-list-60"), for: .normal)
        v.addTarget(self, action: #selector(didTapList(_:)), for: .touchUpInside)
        return v
    }()
    @objc private func didTapList(_ sender:UIButton) {
        if tableView.isHidden {
            tableView.isHidden = false
            
        }else{
            tableView.isHidden = true
            
        }
        
    }
    private lazy var tableView:UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        v.dataSource = self
        v.register(ListCell.self, forCellReuseIdentifier: "cell")
        v.estimatedRowHeight = 60
        v.rowHeight = UITableView.automaticDimension
        v.tableFooterView = UIView()
        v.backgroundColor = .darkGray
        v.isHidden = true
        return v
    }()
    
    init(album:Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addBlurredView()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mediaPlayer.play()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        mediaPlayer.stop()
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    private func setupView() {
        view.addSubview(mediaPlayer)
        view.addSubview(backToAlbum)
        view.addSubview(goToPlayList)
        view.addSubview(tableView)
        setupConstrians()
    }
    private func  setupConstrians() {
        //mediaPlayer
        NSLayoutConstraint.activate([
            mediaPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mediaPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mediaPlayer.topAnchor.constraint(equalTo: view.topAnchor),
            mediaPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        // back button
        NSLayoutConstraint.activate([
            backToAlbum.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backToAlbum.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
        ])
       //list button
        NSLayoutConstraint.activate([
            goToPlayList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            goToPlayList.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
        ])
        // list table
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: backToAlbum.bottomAnchor, constant: 12),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func addBlurredView() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.view.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            view.addSubview(blurEffectView)
        }else {
            view.backgroundColor = .darkGray
        }
    }
    @objc private func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension RadioMusicPlayerViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        album.songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        cell.songName.text = String(indexPath.row + 1) + "." + " " + album.songs[indexPath.row].name
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mediaPlayer.playingIndex = indexPath.row
        mediaPlayer.setupView()
        mediaPlayer.play()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isHidden = true
        
    }
}
