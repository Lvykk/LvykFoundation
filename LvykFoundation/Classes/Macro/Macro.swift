//
//  Macro.swift
//  SwiftDemo
//
//  Created by Lvyk on 2020/4/17.
//  Copyright © 2020 Lvyk. All rights reserved.
//

import Foundation
import UIKit

/// Get Application singleton
let Application = UIApplication.shared

/// get keyWindow
var Key_Window: UIWindow? {
    Application.keyWindow
}

/// Get AppDelegate
let App_Delegate = Application.delegate

/// Get the top safe layout height
@available(iOS 11.0, *)
let SafeAreaInsetsTop = App_Delegate?.window??.safeAreaInsets.top ?? 0

/// Get bottom safe layout height
@available(iOS 11.0, *)
let SafeAreaInsetsBottom = App_Delegate?.window??.safeAreaInsets.bottom ?? 0

/// Notification object singleton
let NOTIFY_Center = NotificationCenter.default

/// root view controller
var App_RootVC: UIViewController? {
    App_Delegate?.window??.rootViewController
}

/// get app name
let GET_App_Name = Bundle.main.infoDictionary?["CFBundleName"] as! String

/// Get BundleId
let GET_BundleId = Bundle.main.bundleIdentifier

/// Get App Build
let GET_App_Build = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

/// Get app version number
let GET_App_Version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

/// Get sandbox Document path
let Get_DocumentPath = NSHomeDirectory() + "/Documents"

/// Get sandbox Library path
let Get_LibraryPath = NSHomeDirectory() + "/Library"

/// Get sandbox Cache path
let Get_CachePath = NSHomeDirectory() + "/Library/Caches"

/// Get sandbox temp path
let Get_TempPath = NSTemporaryDirectory()

/// Determine if it is an iPhone
let DeviceIsiPhone = (UI_USER_INTERFACE_IDIOM() == .phone)

/// Determine if it is an iPad
let DeviceIsiPad = (UI_USER_INTERFACE_IDIOM() == .pad)

/// iPhone 5
let Device_iPhone5 = Decide_iPhone_Device(size: CGSize(width: 640, height: 1136))

/// iPhone 6
let Device_iPhone6 = Decide_iPhone_Device(size: CGSize(width: 750, height: 1334))

/// iPhone 6P
let Device_iPhone6P = Decide_iPhone_Device(size: CGSize(width: 1242, height: 2208))

private func Decide_iPhone_Device(size: CGSize) -> Bool {
    if UIScreen.main.responds(to: NSSelectorFromString("currentMode")) {
        return __CGSizeEqualToSize(size, UIScreen.main.currentMode!.size)
    }
    return false
}

/// get screen size
let GET_Screen = UIScreen.main.bounds

/// Get the width of the screen
let GET_ScreenWidth = GET_Screen.size.width

/// Get the height of the screen
let GET_ScreenHeight = GET_Screen.size.height

/// Get the status bar size
let GET_StartBarFrame = Application.statusBarFrame

/// Get the status bar height
let GET_StartBarHeight = GET_StartBarFrame.height

/// Get the navigation bar height
let GET_TopBarHeight = (GET_StartBarHeight + 44.0)

/// Get TabBar height
let GET_TabBarHeight = CGFloat((Device_iPhone6P || Device_iPhone6 || Device_iPhone5) ? 49.0 : 83.0)

/// hexadecimal color
func HexColor(_ HexString: String) -> UIColor {
    HexColorA(HexString, 1.0)
}

/// hexadecimal color, value with transparency
func HexColorA(_ HexString: String, _ a: CGFloat) -> UIColor {
    let hexString = HexString.trimmingCharacters(in: .whitespacesAndNewlines)
    let scanner = Scanner(string: hexString)

    if hexString.hasPrefix("#") {
        scanner.scanLocation = 1
    }

    var color: UInt32 = 0
    scanner.scanHexInt32(&color)

    let mask = 0x000000ff
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask

    let red = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue = CGFloat(b) / 255.0

    return UIColor(red: red, green: green, blue: blue, alpha: a)
}

/// RGB color
func RGBColor(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    RGBAColor(r, g, b, 1.0)
}

/// RGB color, value with transparency
func RGBAColor(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// Registration Notice
func NOTIFY_ADD(observer: Any, selector: Selector, name: String) {
    NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name(rawValue: name), object: nil)
}

/// send notification
func NOTIFY_POST(name: String, object: Any?) {
    NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object)
}

/// Takedown notice
func NOTIFY_REMOVE(observer: Any, name: String) {
    NotificationCenter.default.removeObserver(observer, name: Notification.Name(rawValue: name), object: nil)
}

/// If the string is empty, return @""
func StringNullToempty(_ str: String) -> String {
    let resutl = StringIsEmpty(str) ? "" : str
    return resutl
}

/// If the string is empty, return the specified string
func StringNullToReplaceStr(_ str: String, _ replaceStr: String) -> String {
    let resutl = StringIsEmpty(str) ? replaceStr : str
    return resutl
}

/// Check if a string is empty
func StringIsEmpty(_ str: String?) -> Bool {
    if str == nil || str!.count < 1 {
        return true
    }
    if str!.isEmpty {
        return true
    }
    if str == "(null)" || str == "null" {
        return true
    }
    return false
}

/// Check if an array is empty
func ArrayIsEmpty(_ array: [Any]) -> Bool {
    if array.isEmpty || array.isEmpty {
        return true
    }
    return false
}

/// Check if dictionary is empty
func DictIsEmpty(_ dict: NSDictionary) -> Bool {
    let str: String! = "\(dict)"
    if str == nil || str == "(null)" || dict.isKind(of: NSNull.self) || dict.allKeys.isEmpty {
        return true
    }
    return false
}

/// View with rounded shadows
func setShowadow(view: UIView, radius: CGFloat = 10.0, shadowRadius: CGFloat = 0, opacity: Float = 1, sColor: UIColor = .black, offset: CGSize = CGSize(width: 3.0, height: 3.0), path: CGPath? = nil) {
    view.layer.cornerRadius = radius
    view.layer.shadowRadius = shadowRadius
    view.layer.shadowOpacity = opacity
    view.layer.shadowColor = sColor.cgColor
    view.layer.shadowOffset = offset
    view.layer.shadowPath = path
}

/// View with rounded corners
func View_Radius(view: UIView, radius: Float) {
    view.layer.cornerRadius = CGFloat(radius)
    view.layer.masksToBounds = true
}

/// View adding rounded corners and borders
func View_Border_Radius(view: UIView, radius: Float, width: Float, color: UIColor) {
    View_Radius(view: view, radius: radius)
    view.layer.borderWidth = CGFloat(width)
    view.layer.borderColor = color.cgColor
}

/// add shadow to view
func View_Shadow(view: UIView, shadowRadius: Float, color: UIColor, opacity: Float, size: CGSize, path: CGPath? = nil) {
    view.layer.shadowRadius = CGFloat(shadowRadius)
    view.layer.shadowColor = color.cgColor
    view.layer.shadowOpacity = opacity
    view.layer.shadowOffset = size
    view.layer.shadowPath = path
}

/// Views add rounded corners and shadows
func setShadow(view: UIView, width: CGFloat, bColor: UIColor,
               sColor: UIColor, offset: CGSize, opacity: Float, radius: CGFloat, sRadius: CGFloat) {
    // set view border width
    view.layer.borderWidth = width
    // set border color
    view.layer.borderColor = bColor.cgColor
    // Set border rounded corners
    view.layer.cornerRadius = radius
    // set shadow color
    view.layer.shadowColor = sColor.cgColor
    // set transparency
    view.layer.shadowOpacity = opacity
    // set shadow radius
    view.layer.shadowRadius = sRadius
    // set shadow offset
    view.layer.shadowOffset = offset
}

/// get pictures
func GET_Image(name: String) -> UIImage? {
    UIImage(named: name)
}

/// Get the big picture
func GET_ImagePath(name: String, format: String) -> UIImage? {
    if let imgPath = Bundle.main.path(forResource: name, ofType: format) {
        return UIImage(contentsOfFile: imgPath)
    }
    return nil
}

/// Open the specified URL
func OpenUrl(url: String, completion: ((Bool) -> Void)?) {
    if #available(iOS 10.0, *) {
        Application.open(URL(string: url)!, options: [.universalLinksOnly: false], completionHandler: completion)
    } else {
        Application.openURL(URL(string: url)!)
    }
}

/// DEBUG printout
func print<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    #if DEBUG || DEVELOP
    /// get current time
    let now = Date()
    /// Create a date formatter
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    /// To truncate the string at the end of the path
    let lastName = ((fileName as NSString).pathComponents.last!)
    print("\(dformatter.string(from: now)) [\(lastName)][\(lineNumber) Line] : \(message)")
    #endif
}

/// Get the current application channel
func CurrentApplicationChannel() -> String {
    if Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt" {
        return "testflight"
    }
    return "appstore"
}

extension Array where Element: Hashable {
    var deduplicates: [Element] {
        var keys: [Element: ()] = [:]
        return filter { keys.updateValue((), forKey: $0) == nil }
    }
}
