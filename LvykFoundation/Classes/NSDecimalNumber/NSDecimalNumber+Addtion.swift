//
//  NSDecimalNumber+Addtion.swift
//  NeoLine
//
//  Created by Lvyk on 2021/10/21.
//

import Foundation
import BigInt

enum NSDecimalNumberError: Error {
    case InvalidType
}

extension NSDecimalNumber {
    convenience init(number: Any) {
        let value = (try? Self.checkDecimalNumber(number)) ?? .zero
        self.init(decimal: value.decimalValue)
    }

    func Add(_ value: Any, _ handler: NSDecimalNumberBehaviors? = nil) throws -> NSDecimalNumber {
        let another = try checkDecimalNumber(value)
        guard handler != nil else { return adding(another) }
        return adding(another, withBehavior: handler)
    }

    func Subtract(_ value: Any, _ handler: NSDecimalNumberBehaviors? = nil) throws -> NSDecimalNumber {
        let another = try checkDecimalNumber(value)
        guard handler != nil else { return subtracting(another) }
        return subtracting(another, withBehavior: handler)
    }

    func Multiply(_ value: Any, _ handler: NSDecimalNumberBehaviors? = nil) throws -> NSDecimalNumber {
        let another = try checkDecimalNumber(value)
        guard handler != nil else { return multiplying(by: another) }
        return multiplying(by: another, withBehavior: handler)
    }

    func Divide(_ value: Any, _ handler: NSDecimalNumberBehaviors? = nil) throws -> NSDecimalNumber {
        let another = try checkDecimalNumber(value)
        guard handler != nil else { return dividing(by: another) }
        return dividing(by: another, withBehavior: handler)
    }

    func compareDecimalNumber(_ value: Any) throws -> ComparisonResult {
        let another = try checkDecimalNumber(value)
        return compare(another)
    }

    func handlerDecimalNumber(_ mode: NSDecimalNumber.RoundingMode, _ scale: Int16) throws -> NSDecimalNumber {
        let handler = NSDecimalNumberHandler(roundingMode: mode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return try Self.handlerDecimalNumber(self, handler)
    }

    static func handlerDecimalNumber(_ value: Any, _ handler: NSDecimalNumberBehaviors? = nil) throws -> NSDecimalNumber {
        let another = try checkDecimalNumber(value)
        return another.rounding(accordingToBehavior: handler)
    }

    private func checkDecimalNumber(_ value: Any) throws -> NSDecimalNumber {
        guard !decimalValue.isNaN else { throw NSDecimalNumberError.InvalidType }
        return try Self.checkDecimalNumber(value)
    }

    private static func checkDecimalNumber(_ value: Any) throws -> NSDecimalNumber {
        let another: NSDecimalNumber
        if value is String || value is NSString {
            another = NSDecimalNumber(string: value as? String)
        } else if let number = value as? Int {
            another = NSDecimalNumber(value: number)
        } else if let number = value as? NSNumber, number.decimalValue.isNormal {
            another = NSDecimalNumber(decimal: number.decimalValue)
        } else if let number = value as? Decimal {
            another = NSDecimalNumber(decimal: number)
        } else if let number = value as? NSDecimalNumber, number.decimalValue.isNormal {
            another = number
        } else if let bigNmuber = value as? BigUInt {
            another = NSDecimalNumber(string: bigNmuber.description)
        } else {
            throw NSDecimalNumberError.InvalidType
        }
        guard !another.decimalValue.isNaN else { throw NSDecimalNumberError.InvalidType }
        return another
    }
}

extension NSDecimalNumber {
    convenience init(string: String, base: Int) {
        guard base >= 2, base <= 16 else { fatalError("Invalid base") }

        let digits = "0123456789ABCDEF"
        let baseNum = NSDecimalNumber(value: base)

        var res = NSDecimalNumber(value: 0)
        for ch in string {
            let index = digits.firstIndex(of: ch)!
            let digit = digits.distance(from: digits.startIndex, to: index)
            res = res.multiplying(by: baseNum).adding(NSDecimalNumber(value: digit))
        }

        self.init(decimal: res.decimalValue)
    }

    func toBase(_ base: Int) -> String {
        guard base >= 2, base <= 16 else { fatalError("Invalid base") }

        // Support higher bases by added more digits
        let digits = "0123456789ABCDEF"
        let rounding = NSDecimalNumberHandler(roundingMode: .down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let baseNum = NSDecimalNumber(value: base)

        var res = ""
        var val = self
        while val.compare(0) == .orderedDescending {
            let next = val.dividing(by: baseNum, withBehavior: rounding)
            let round = next.multiplying(by: baseNum)
            let diff = val.subtracting(round)
            let digit = diff.intValue
            let index = digits.index(digits.startIndex, offsetBy: digit)
            res.insert(digits[index], at: res.startIndex)

            val = next
        }

        return res
    }
}
