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

class appExtension: NSObject {

}
