//
//  ViewController.swift
//  playMp3Url001
//
//  Created by hoang the anh on 15/05/2022.
//

import UIKit
import Foundation

class DiscoverViewController: UIViewController , UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var subjectResponse: SubjectResponse?
    weak var mainTabBar: MainTabBarControllerDelegate?
    
    weak var trackDetail:TrackDetailView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
        tableView.delegate = self
        tableView.dataSource = self
        configureItem()

    }
    private func configureItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-back-48"), style: .plain, target: self, action: #selector(didTapLeftItem))
    }
    @objc private func didTapLeftItem() {
        dismiss(animated: true, completion: nil)
        trackDetail?.stop()
    }
    func loadJson() {
            guard let path = Bundle.main.path(forResource: "jsonfMusic", ofType: "json") else {return}
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                subjectResponse = try jsonDecoder.decode(SubjectResponse.self, from: jsonData)
                
            }catch{
                print("error")
            }
            
        }
    
    func moveOnProductDetail(tindex:Int, cindex:Int) {
let storyboard = UIStoryboard(name: "TrackListViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TrackListViewController") as! TrackListViewController
        vc.subjectTrack = subjectResponse?.response[tindex].datasubject[cindex]
        vc.tabBarDelegateM = mainTabBar
        trackDetail?.delegateM = vc
        vc.trackDetailV = trackDetail
        navigationController?.pushViewController(vc, animated: true)
       
    }

}

extension DiscoverViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subjectResponse?.response.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "discoverCell") as? SubjectCell else {return UITableViewCell()}
        cell.subjectType = subjectResponse?.response[indexPath.row]
        
        cell.index = indexPath.row
        cell.didSelectClosure = {tableIndex, collectIndex in
            if let tabIndexp = tableIndex, let cellIndexp = collectIndex {
                self.moveOnProductDetail(tindex: tabIndexp, cindex: cellIndexp)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
   
}
