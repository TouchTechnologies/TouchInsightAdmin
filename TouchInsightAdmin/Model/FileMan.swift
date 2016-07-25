//
//  FileMan.swift
//  TouchInsightAdmin
//
//  Created by Thirawat Phannet on 21/7/59.
//  Copyright © พ.ศ. 2559 weerapons suwanchatree. All rights reserved.
//

import Foundation
import UIKit

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
