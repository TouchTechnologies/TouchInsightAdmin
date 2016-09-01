//
//  appExtension.swift
//  TouchInsightAdmin
//
//  Created by Thirawat Phannet on 24/8/59.
//  Copyright © พ.ศ. 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit

extension String {
    var length: Int {
        return (self as NSString).length
    }
}

extension String {
    func toDateFormattedWith(format:String)-> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.dateFromString(self)!
    }
}



//public enum ImageFormat {
//    case PNG
//    case JPEG(CGFloat)
//}
extension UIImage {
    public func toBase64() -> String {
//        var imageData: NSData
//        imageData = UIImagePNGRepresentation(self)!
//        switch format {
//        case .PNG: imageData = UIImagePNGRepresentation(self)!
//        case .JPEG(let compression): imageData = UIImageJPEGRepresentation(self, compression)!
//        }
        let imageData:NSData = UIImagePNGRepresentation(self)!
        return imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
    }
}

extension UIImage {
    public func toBase64_2() -> String {
        //create image instance
        //with image name from bundle
        let imageData = UIImagePNGRepresentation(self)
        
        //OR with path
//        var url:NSURL = NSURL.URLWithString(“urlHere”)
//        var imageData:NSData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
        
        let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        //print(base64String)
        return base64String
    }
}

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

