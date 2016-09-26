//
//  fileManager.swift
//  TouchInsightAdmin
//
//  Created by Touch on 6/7/59.
//  Copyright © พ.ศ. 2559 weerapons suwanchatree. All rights reserved.
//

// https://iosdevcenters.blogspot.com/2016/04/save-and-get-image-from-document.html

import Foundation
class fileManager: NSObject {
    
    func saveImageDocumentDirectory(){
        let fileManager = NSFileManager.defaultManager()
        let paths = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent("apple.jpg")
        let image = UIImage(named: "apple.jpg")
        print(paths)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFileAtPath(paths as String, contents: imageData, attributes: nil)
    }
}