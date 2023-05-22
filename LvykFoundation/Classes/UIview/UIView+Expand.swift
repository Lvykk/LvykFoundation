//
//  UIView+Expand.swift
//  MoyaUtil
//
//  Created by Lvyk on 2023/5/19.
//

import UIKit

extension UIView {
    @IBInspectable
    var setCornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable
    var setBorderColor: UIColor {
        get {
            UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable
    var setBorderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    func bezierRadius(_ path_frame: CGRect, _ cornerRadius: CGSize, roundingCorners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]) {
        let bezier_path = UIBezierPath(roundedRect: path_frame, byRoundingCorners: roundingCorners, cornerRadii: cornerRadius)
        let circle_layer: CAShapeLayer = .init()
        circle_layer.path = bezier_path.cgPath
        circle_layer.frame = path_frame
        layer.mask = circle_layer
    }

    @objc func lyk_configWithData(_ data: Any) {}
}
