//
//  Nib.swift
//  playMp3Url001
//
//  Created by hoang the anh on 15/05/2022.
//

import Foundation
import UIKit
extension UIView {
    class func loadFromNib<T: UIView>() -> T {
//        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?[0] as! T
       //yêu cầu first object hoặc top level object hoặc [0]
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as! T
    }
}
