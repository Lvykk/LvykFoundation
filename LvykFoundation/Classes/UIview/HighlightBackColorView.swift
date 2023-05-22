//
//  HighlightBackColorView.swift
//  NeoLine
//
//  Created by Lvyk on 2022/11/4.
//

import UIKit

class HighlightBackColorView: UIView {
    var touchesEndedAction: ((_ tag: Int) -> Void)?

    @IBInspectable
    var selectColor: UIColor?

    @IBInspectable
    var normalColor: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    func commonInit() {
        normalColor = backgroundColor
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        backgroundColor = selectColor
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        backgroundColor = normalColor
        if let touch = touches.map({ $0 }).last, CGRectContainsPoint(bounds, touch.location(in: self)) {
            touchesEndedAction?(tag)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let touch = touches.map({ $0 }).last, CGRectContainsPoint(bounds, touch.location(in: self)) {
            backgroundColor = selectColor
        } else {
            backgroundColor = normalColor
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        backgroundColor = normalColor
    }
}
