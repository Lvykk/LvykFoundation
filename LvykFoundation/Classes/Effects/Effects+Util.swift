//
//  ImageEffects+Extensions.swift
//  O3
//
//  Created by Lvyk on 2022/5/19.
//

import UIKit

extension UIView {
    /// Get a UIImage from the UIView
    /// - parameter opaque:
    /// A Boolean flag indicating whether the image is opaque. Specify true to ignore the alpha channel. Specify false to handle any partially transparent pixels.
    /// - parameter scale:
    /// The scale factor to apply to the image. If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
    func renderImage(opaque: Bool = false, scale: CGFloat = 0) -> UIImage {
        if #available(iOS 10.0, tvOS 10.0, *) {
            let format = UIGraphicsImageRendererFormat.default()
            format.opaque = opaque
            format.scale = scale
            return UIGraphicsImageRenderer(size: bounds.size, format: format).image { layer.render(in: $0.cgContext) }
        } else {
            // Fallback on earlier versions
            // The following methods will only return a 8-bit per channel context in the DeviceRGB color space.
            // Any new bitmap drawing code is encouraged to use UIGraphicsImageRenderer in lieu of this API.
            UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, scale)
            defer { UIGraphicsEndImageContext() }
            layer.render(in: UIGraphicsGetCurrentContext()!)
            return UIGraphicsGetImageFromCurrentImageContext()!
        }
    }
}

extension UIImage {
    /// Return a new image cropped to a rectangle.
    /// - parameter rect:
    /// The rectangle to crop.
    func cropped(to rect: CGRect) -> UIImage {
        // a UIImage is either initialized using a CGImage, a CIImage, or nothing
        if let cgImage = cgImage {
            // CGImage.cropping(to:) is magnitudes faster than UIImage.draw(at:)
            if let cgCroppedImage = cgImage.cropping(to: rect) {
                return UIImage(cgImage: cgCroppedImage)
            } else {
                return UIImage()
            }
        }
        if let ciImage = ciImage {
            // Core Image's coordinate system mismatch with UIKit, so rect needs to be mirrored.
            var ciRect = rect
            ciRect.origin.y = ciImage.extent.height - ciRect.origin.y - ciRect.height
            let ciCroppedImage = ciImage.cropped(to: ciRect)
            return UIImage(ciImage: ciCroppedImage)
        }
        return self
    }
}
