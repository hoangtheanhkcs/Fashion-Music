//
//  ViewController.swift
//  playMp304
//
//  Created by hoang the anh on 26/04/2022.
//

import UIKit

class RadioViewController: UIViewController {
    
   private let albums = Album.get()

    private lazy var tableView:UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        v.dataSource = self
        v.register(AlbumTableViewCell.self, forCellReuseIdentifier: "cell")
        v.estimatedRowHeight = 132
        v.rowHeight = UITableView.automaticDimension
        v.tableFooterView = UIView()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
   
    private func  setupView() {
        title = "My Music Player"
        view.addSubview(tableView)
        
        setupConstrains()
        
    }
    
    private func setupConstrains() {
        //uitableview
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor), tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor), tableView.topAnchor.constraint(equalTo: view.topAnchor), tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }

}

extension RadioViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        cell.album = albums[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RadioMusicPlayerViewController(album: albums[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
