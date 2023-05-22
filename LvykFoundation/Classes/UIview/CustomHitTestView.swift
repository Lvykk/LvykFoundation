//
//  SectionHeaderView.swift
//  NeoLine
//
//  Created by Lvyk on 2022/11/8.
//

import UIKit

class CustomHitTestView: UIView {
    var customHitTest: ((_ point: CGPoint, _ event: UIEvent?) -> UIView?)?

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = customHitTest?(point, event) else {
            return super.hitTest(point, with: event)
        }
        return view
    }
}
