//
//  LYKRegexHelper.swift
//  SwiftDemo
//
//  Created by Lvyk on 2020/5/6.
//  Copyright © 2020 Lvyk. All rights reserved.
/*
 *  Regular related tools
 */

import Foundation

struct RegexTemplate {
    /// Check mailbox
    static let Mail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"

    /// Verify ID
    static let Phone = "^(13[0-9]|14[5|7]|15[0|1|2|3|4|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$"

    /// pure Chinese
    static let ValidChinese = "^[\\u4e00-\\u9fa5]{0,}$"

    /// Numbers starting with 0 or non-0
    static let NonZero = "^(0|-?[1-9][0-9]*)$"

    /// Integers that do not start with 0
    static let AllNum = "^(-?[1-9][0-9]*)$"

    /// 2 decimal floating point numbers
    static let TwoDecimal = "^(0|-?[1-9][\\d]*)+(.[\\d]{2})?$"

    /// Floating point number specifying maximum number of digits
    static func isDecimal(digits: Int = 1) -> String {
        "^\\d*\\.{0,1}(\\d{1,\(NSNumber(value: digits).stringValue)})?$"
    }

    /// Write decimals starting with 0 or non-zero
    static func isAllNumDecimal(digits: Int = 1) -> String {
        "^(0.{0,1}|-?[1-9][0-9]*.{0,1})(\\d{1,\(NSNumber(value: digits).stringValue)})?$"
    }

    static let url = "^(?=^.{3,255}$)[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+$"

    static let webUrl = "^(?=^.{3,255}$)(http(s)?://)?(www\\.)?[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+(:\\d+)*(/\\w+\\.\\w+)*$"

    /// Strong Password length greater than or equal to 8 digits Contains uppercase letters [A-Z] Lowercase letters [a-z] Numbers [0-9] Special characters that are not word characters [punctuation marks, spaces, etc.]
    ///    ^(?=.{9,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$
    static let strongRegex = "^(?![a-zA-z]+$)(?!\\d+$)(?![!@#$%^&*]+$)(?![a-zA-z\\d]+$)(?![a-zA-z!@#$%^&*]+$)(?![\\d!@#$%^&*]+$)[a-zA-Z\\d!@#$%^&*]+$"
    /// Medium Password length is greater than or equal to 8 digits Uppercase letters[A-Z] Lowercase letters[a-z] or Uppercase letters[A-Z] Numbers[0-9] or Lowercase letters[a-z] Numbers[0-9] Any character
    static let mediumRegex = "^(?![a-zA-z]+$)(?!\\d+$)(?![!@#$%^&*]+$)[a-zA-Z\\d!@#$%^&*]+$"
    /// Weak Greater than or equal to 8 bits Any character or number
    static let enoughRegex = "^(?:\\d+|[a-zA-Z]+|[!@#$%^&*]+)$"

    /// Determine if a character is
    static let stringHexRegex = "^[A-Fa-f0-9]+$"

    /// Determine if a character is a lowercase letter or a space
    static let lowercaseRegex = "^[a-z ]+$"

    static let isHex = "^[0-9A-Fa-f]+$"
}

public struct RegexHelper {
    let regex: NSRegularExpression

    init(_ pattern: String, _ options: NSRegularExpression.Options = .caseInsensitive) throws {
        try regex = NSRegularExpression(pattern: pattern, options: options)
    }

    func match(_ input: String, options: NSRegularExpression.MatchingOptions = []) -> Bool {
        let matches = regex.matches(in: input, options: options, range: NSMakeRange(0, input.utf16.count))
        return !matches.isEmpty
    }
}

precedencegroup MatchPrecedence {
    associativity: none
    higherThan: DefaultPrecedence
}

infix operator =~: MatchPrecedence
postfix operator ^~

public func =~ (object: (input: String, options: NSRegularExpression.Options), template: String) -> Bool {
    do {
        return try RegexHelper(template, object.options).match(object.input)
    } catch _ {
        return false
    }
}

public func =~ (object: String, template: String) -> Bool {
    do {
        return try RegexHelper(template).match(object)
    } catch _ {
        return false
    }
}
