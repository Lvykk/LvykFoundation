//
//  UIView+NIB.swift
//  MoyaUtil
//
//  Created by Lvyk on 2023/5/19.
//

import UIKit

extension UIView {
    // MARK: - Nibs

    class func loadNib() -> UINib? {
        loadNibNamed("\(self)")
    }

    class func loadNibNamed(_ nibName: String) -> UINib? {
        loadNibNamed(nibName, bundle: Bundle.main)
    }

    class func loadNibNamed(_ nibName: String, bundle: Bundle?) -> UINib? {
        UINib(nibName: nibName, bundle: bundle)
    }

    class func loadInstanceFromNib() -> Self {
        loadInstanceFromNib(withName: "\(self)")
    }

    class func loadInstanceFromNib(withName nibName: String) -> Self {
        loadInstanceFromNib(withName: nibName, owner: nil)
    }

    class func loadInstanceFromNib(withName nibName: String, owner: Any?) -> Self {
        loadInstanceFromNib(withName: nibName, owner: owner, bundle: Bundle.main)
    }

    class func loadInstanceFromNib(withName nibName: String, owner: Any?, bundle: Bundle) -> Self {
        var result: UIView? = nil
        let elements = bundle.loadNibNamed(nibName, owner: owner, options: nil)! as [AnyObject]
        for object in elements {
            if object.isKind(of: self.self) {
                result = object as? UIView
                break
            }
        }
        return result as! Self
    }
}
