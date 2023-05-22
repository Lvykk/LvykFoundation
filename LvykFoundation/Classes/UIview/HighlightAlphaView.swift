//
//  HighlightAlphaView.swift
//  NeoLine
//
//  Created by Lvyk on 2022/11/4.
//

import UIKit

class HighlightAlphaView: UIView {
    var touchesEndedAction: ((_ tag: Int) -> Void)?

    @IBInspectable
    var selectAlpha: CGFloat = 0.3

    private var oldAlpha: CGFloat = 1.0

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
        oldAlpha = alpha
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        alpha = selectAlpha
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        alpha = oldAlpha
        if let touch = touches.map({ $0 }).last, CGRectContainsPoint(bounds, touch.location(in: self)) {
            touchesEndedAction?(tag)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let touch = touches.map({ $0 }).last, CGRectContainsPoint(bounds, touch.location(in: self)) {
            alpha = selectAlpha
        } else {
            alpha = oldAlpha
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        alpha = oldAlpha
    }
}
