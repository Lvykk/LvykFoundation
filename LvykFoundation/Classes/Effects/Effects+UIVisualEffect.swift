//
//  Effects+UIVisualEffect.swift
//  O3
//
//  Created by Lvyk on 2022/5/19.
//

import UIKit

public extension UIVisualEffectView {
    static func blurWithUIKit(style: UIBlurEffect.Style) -> UIView {
        let blurEffect = UIBlurEffect(style: style)
        let alphaView = UIVisualEffectView(effect: blurEffect)
        return alphaView
    }

    static func vibrancyWithUIKit(style: UIBlurEffect.Style) -> UIView {
        let blurEffect = UIVibrancyEffect(blurEffect: UIBlurEffect(style: style))
        let alphaView = UIVisualEffectView(effect: blurEffect)
        return alphaView
    }
}
