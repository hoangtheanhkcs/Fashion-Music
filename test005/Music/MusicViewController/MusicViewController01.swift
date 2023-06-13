//
//  MusicViewController01.swift
//  playMp3Url001
//
//  Created by hoang the anh on 15/05/2022.
//

import UIKit
import AVKit

class MusicViewController01: UIViewController, UITableViewDelegate, UISearchBarDelegate {

    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!
    var dataTrack :[TrackModel] = []
    var timer: Timer?
    weak var tabBarDelegate: MainTabBarControllerDelegate?
    var trackDetailMM:TrackDetailView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setTableView()
          setupSearchController()
configureItem()
    }
    
    private func configureItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-back-48"), style: .plain, target: self, action: #selector(didTapLeftItem))
    }
    @objc private func didTapLeftItem() {
        dismiss(animated: true, completion: nil)
        trackDetailMM?.stop()
    }
    
private func setTableView() {
        let nib = UINib(nibName: "TrackCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Nhập tên bài hát"
        searchController.searchBar.delegate = self
    }
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        if searchText == "" {
            dataTrack = []
            dataTrack.removeAll()
            tableView.reloadData()
        }else {
            getRequest(url: searchText)
            tableView.reloadData()
           }
        tableView.reloadData()
    }
}

extension MusicViewController01:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataTrack.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrackCell
        cell.getTrack(dataTrack[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.tabBarDelegate?.maximizeTrackDetail(viewModel: dataTrack[indexPath.row])
        trackDetailMM?.tagg = 0
        
    }
}
  
extension MusicViewController01: TrackMovingDelegate {
    
    private func getTrack(isForwardTrack: Bool) -> TrackModel? {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        tableView.deselectRow(at: indexPath, animated: true)
        var nextIndexPath: IndexPath!
        if isForwardTrack {
            nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if nextIndexPath.row == self.dataTrack.count {
                nextIndexPath.row = 0
            }
        } else {
            nextIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            if nextIndexPath.row == -1 {
                nextIndexPath.row = self.dataTrack.count - 1
            }
        }
        tableView.selectRow(at: nextIndexPath, animated: true, scrollPosition: .none)
        let cellViewModel = self.dataTrack[nextIndexPath.row]
        return cellViewModel
    }
    
    func moveBackForPreviousTrack() -> TrackModel? {
        return getTrack(isForwardTrack: false)
    }
    
    func moveForwardForPreviousTrack() -> TrackModel? {
        return getTrack(isForwardTrack: true)
    }
}
