//
//  String+Hex.swift
//  MoyaUtil
//
//  Created by Lvyk on 2023/5/19.
//

import Foundation

extension String {
    func toHexString() -> String {
        let data = self.data(using: .utf8)!
        let hexString = data.map { String(format: "%02x", $0) }.joined()
        return hexString
    }

    func hasHexPrefix() -> Bool {
        hasPrefix("0x")
    }

    func stripHexPrefix() -> String {
        if hasHexPrefix() {
            let indexStart = index(startIndex, offsetBy: 2)
            return String(self[indexStart...])
        }
        return self
    }

    func verifyHexPrefix() -> String {
        if hasHexPrefix() {
            return self
        }
        return "0x" + self
    }
}
