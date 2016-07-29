//
//  FileMan.swift
//  TouchInsightAdmin
//
//  Created by Thirawat Phannet on 21/7/59.
//  Copyright © พ.ศ. 2559 weerapons suwanchatree. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class FileMan: NSObject{
    
    func checkFile(fileName: String) -> Bool {
        var returnVal = Bool()
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.URLByAppendingPathComponent(fileName).path!
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(filePath) {
            print("FILE AVAILABLE")
            returnVal = true
        } else {
            print("FILE NOT AVAILABLE")
            returnVal = false
        }
        return returnVal
    }
    
    
    func resizeImage(image: UIImage, maxSize: CGFloat) -> UIImage {
        
        var newImage = UIImage()
        
        if(image.size.height > maxSize || image.size.height > maxSize){
            
//            var scale = CGFloat()
//            if(image.size.height > image.size.width){
//                scale = maxSize / image.size.height
//            }else{
//                scale = maxSize / image.size.width
//            }
//            
//            let newHeight = image.size.height * scale
//            UIGraphicsBeginImageContext(CGSizeMake(maxSize, newHeight))
//            image.drawInRect(CGRectMake(0, 0, maxSize, newHeight))
//            newImage = UIGraphicsGetImageFromCurrentImageContext()
//            
//            UIGraphicsEndImageContext()
            
            let old_w = image.size.width
            let old_h = image.size.height
            var thumb_w = CGFloat()
            var thumb_h = CGFloat()
            
            //var scale = CGFloat()
            if(old_w > old_h){
                thumb_w = maxSize
                thumb_h = old_h / old_w * maxSize
            }else if(old_h > old_w){
                thumb_w = old_w / old_h * maxSize
                thumb_h = maxSize
            }else{
                thumb_w = maxSize
                thumb_h = maxSize
            }
            
            UIGraphicsBeginImageContext(CGSizeMake(thumb_w, thumb_h))
            image.drawInRect(CGRectMake(0, 0, thumb_w, thumb_h))
            newImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            
        }else{
            
            newImage = image
            
        }
        
        
        return newImage
    }
    
    
//    
////    -(BOOL)fn_File_SaveToDir:(NSString*)getPath fileName:(NSString*)getFile data:(NSData*)getData{
//    
//    func saveFileToDir(getPath: String, fileName: String, data: NSData) -> Bool {
//        var returnVal = Bool()
//        
//        
//        
//        var rtData: Bool = false
//        var strPath: String
//        var error: NSError
//        var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//        
//        if getPath.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
//            strPath = paths[0] as! String
//        } else {
//            strPath = paths[0].stringByAppendingPathComponent(getPath)
//        }
//        
//        if !fileName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
//            strPath = strPath.stringByAppendingPathComponent(fileName)
//            if data {
//                if !NSFileManager.defaultManager().createFileAtPath(strPath, contents: data, attributes: nil) {
//                    print("Save to directory error: \(error)")
//                    rtData = false
//                } else {
//                    rtData = true
//                    
//                }
//            } else {
//                rtData = true
//                
//            }
//        } else {
//            rtData = true
//            
//        }
//        return rtData
//
//        
//        
//        
//        return returnVal
//    }
}
