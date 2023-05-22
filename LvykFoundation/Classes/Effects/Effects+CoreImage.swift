//
//  Effects+CoreImage.swift
//  O3
//
//  Created by Lvyk on 2022/5/19.
//

import UIKit
import CoreImage

public extension UIImage {
    func gaussianBlurWithCoreImage(inputRadius: Float = 10.0) -> UIImage {
        // Filter the UIImage
        let imageToFilter = ciImage ?? CIImage(cgImage: cgImage!)
        let filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputImage": imageToFilter,
                                                                            "inputRadius": inputRadius])!

        // create UIImage from filtered image (adjust rect because blur changed size of image)
        // https://stackoverflow.com/questions/20531938/cigaussianblur-image-size
        let filteredImage = UIImage(ciImage: filter.outputImage!.cropped(to: imageToFilter.extent))
        return filteredImage
    }

    func motionBlurWithCoreImage(inputRadius: Float = 20.0, inputAngle: Float = 0.0) -> UIImage {
        // Filter the UIImage
        let imageToFilter = ciImage ?? CIImage(cgImage: cgImage!)
        let filter = CIFilter(name: "CIMotionBlur", parameters: ["inputImage": imageToFilter,
                                                                          "inputRadius": inputRadius,
                                                                          "inputAngle": inputAngle])!

        // create UIImage from filtered image (adjust rect because blur changed size of image)
        // https://stackoverflow.com/questions/20531938/cigaussianblur-image-size
        let filteredImage = UIImage(ciImage: filter.outputImage!.cropped(to: imageToFilter.extent))
        return filteredImage
    }

    func zoomBlurWithCoreImage(inputAmount: Float = 20.0, inputCenter: CGPoint = CGPoint(x: 150, y: 150)) -> UIImage {
        // Filter the UIImage
        let imageToFilter = ciImage ?? CIImage(cgImage: cgImage!)
        let filter = CIFilter(name: "CIZoomBlur", parameters: ["inputImage": imageToFilter,
                                                                        "inputAmount": inputAmount,
                                                                        "inputCenter": CIVector(cgPoint: inputCenter)])!

        // create UIImage from filtered image (adjust rect because blur changed size of image)
        // https://stackoverflow.com/questions/20531938/cigaussianblur-image-size
        let filteredImage = UIImage(ciImage: filter.outputImage!.cropped(to: imageToFilter.extent))
        return filteredImage
    }

    func boxBlurWithCoreImage(inputRadius: Float = 10.0) -> UIImage {
        // Filter the UIImage
        let imageToFilter = ciImage ?? CIImage(cgImage: cgImage!)
        let filter = CIFilter(name: "CIBoxBlur", parameters: ["inputImage": imageToFilter,
                                                                       "inputRadius": inputRadius])!

        // create UIImage from filtered image (adjust rect because blur changed size of image)
        // https://stackoverflow.com/questions/20531938/cigaussianblur-image-size
        let filteredImage = UIImage(ciImage: filter.outputImage!.cropped(to: imageToFilter.extent))
        return filteredImage
    }

    func discBlurWithCoreImage(inputRadius: Float = 8.0) -> UIImage {
        // Filter the UIImage
        let imageToFilter = ciImage ?? CIImage(cgImage: cgImage!)
        let filter = CIFilter(name: "CIDiscBlur", parameters: ["inputImage": imageToFilter,
                                                                        "inputRadius": inputRadius])!

        // create UIImage from filtered image (adjust rect because blur changed size of image)
        // https://stackoverflow.com/questions/20531938/cigaussianblur-image-size
        let filteredImage = UIImage(ciImage: filter.outputImage!.cropped(to: imageToFilter.extent))
        return filteredImage
    }
}
