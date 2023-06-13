//
//  Storyboard.swift
//  playMp3Url001
//
//  Created by hoang the anh on 15/05/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func loadFromStoryBoard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewcontroller = storyboard.instantiateViewController(withIdentifier: name) as? T {
            return viewcontroller
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard")
        }
    }
    
}
