//
//  String+Extension.swift
//  MoyaUtil
//
//  Created by Lvyk on 2023/5/19.
//

import UIKit

public extension String {
    /// Copy to clipboard
    internal func clipboard(_ complete: (() -> Void)?) {
        let pastboard = UIPasteboard.general
        pastboard.string = self
        complete?()
    }

    /// Start intercepting from a certain position:
    /// - Parameter index: starting point
    func substring(from index: Int) -> String {
        if count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<endIndex]
            return String(subString)
        } else {
            return ""
        }
    }

    /// Intercept from zero to a certain position:
    /// - Parameter index: reach a certain position
    func substring(to index: Int) -> String {
        if count > index {
            let endindex = self.index(startIndex, offsetBy: index)
            let subString = self[startIndex..<endindex]
            return String(subString)
        } else {
            return self
        }
    }

    /// intercept within a certain range
    /// - Parameter rangs: scope
    func subString(rang rangs: NSRange) -> String {
        var string = String()
        if rangs.location >= 0, count > (rangs.location + rangs.length) {
            let startIndex = index(self.startIndex, offsetBy: rangs.location)
            let endIndex = index(self.startIndex, offsetBy: rangs.location + rangs.length)
            let subString = self[startIndex..<endIndex]
            string = String(subString)
        }
        return string
    }
}
