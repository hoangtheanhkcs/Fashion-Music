//
//  TrackListViewController.swift
//  playMp3Url001
//
//  Created by hoang the anh on 01/06/2022.
//

import UIKit
import AVKit

class TrackListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var subjectTrack :SubjectTrack?
    var timer: Timer?
    weak var tabBarDelegateM: MainTabBarControllerDelegate?
    
    var trackDetailV:TrackDetailView?
    
    
//    weak var delegateN:TrackMovingDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
       
    }
    private func setTableView() {
            tableView.delegate = self
            tableView.dataSource = self
        }


}

extension TrackListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subjectTrack?.data.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackSubjectCell", for: indexPath) as! TrackSubjectCell
        cell.getTrack((subjectTrack?.data[indexPath.row])!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tabBarDelegateM?.maximizeTrackDetail(viewModel: subjectTrack?.data[indexPath.row])
        
        trackDetailV?.tagg = 1
        
    }
    
}

extension TrackListViewController: TrackMovingDelegateM {
    
    private func getTrack(isForwardTrack: Bool) -> TrackModel? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        tableView.deselectRow(at: indexPath, animated: true)
        var nextIndexPath: IndexPath!
        if isForwardTrack {
            nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if nextIndexPath.row == subjectTrack?.data.count {
                nextIndexPath.row = 0
            }
        } else {
            nextIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            if nextIndexPath.row == -1 {
                nextIndexPath.row = (subjectTrack?.data.count)! - 1
            }
        }
        tableView.selectRow(at: nextIndexPath, animated: true, scrollPosition: .none)
        let cellViewModel = subjectTrack?.data[nextIndexPath.row]
        return cellViewModel
    }
    
    func moveBackForPreviousTrackM() -> TrackModel? {
        return getTrack(isForwardTrack: false)
    }
    
    func moveForwardForPreviousTrackM() -> TrackModel? {
        return getTrack(isForwardTrack: true)
    }
}
