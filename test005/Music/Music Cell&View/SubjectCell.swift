//
//  SubjectCell.swift
//  playMp3Url001
//
//  Created by hoang the anh on 01/06/2022.
//

import UIKit

typealias DidSelectclosureMusic = ((_ tableIndext: Int?, _ collectionIndex:Int?) -> Void)

class SubjectCell: UITableViewCell {
    
    @IBOutlet weak var subjectTypeLable: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var index:Int?
    var didSelectClosure:DidSelectclosureMusic?
    var subjectType:SubjectType? {
        didSet {
            subjectTypeLable.text = subjectType?.typemusic
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}

extension SubjectCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        subjectType?.datasubject.count ?? 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubjectCollectionViewCell", for: indexPath) as? SubjectCollectionViewCell else {return UICollectionViewCell()}
        cell.collectionImage.image = UIImage(named: (subjectType?.datasubject[indexPath.row].subjectImage)!)
        cell.collectionSubjectLable.text = subjectType?.datasubject[indexPath.row].subject
        cell.setLayerCollectionCell()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectClosure?(index, indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
       }
    
    
    
}
