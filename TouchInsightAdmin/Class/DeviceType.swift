//
//  CheckDevice.swift
//  JOBBKK
//
//  Created by Thirawat Phannet on 13/11/58.
//  Copyright © พ.ศ. 2558 Thirawat Phannet. All rights reserved.
//

import UIKit
import Foundation

public class DeviceType {
    public class var isIpad:Bool {
        if #available(iOS 8.0, *) {
            return UIScreen.mainScreen().traitCollection.userInterfaceIdiom == .Pad
        } else {
            return (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        }
    }
    public class var isIphone:Bool {
//        #if iOS8target
//            // iOS 8+ compatible code
//        #else
//            if #available(iOS 8.0, *) {
//                // repeat iOS 8+ compatible code again!
//            } else {
//                // iOS 7 code
//            }
//        #endif
        
        if #available(iOS 8.0, iOSApplicationExtension 8.0, *) {
            return UIScreen.mainScreen().traitCollection.userInterfaceIdiom == .Phone
        }else{
            return UIDevice.currentDevice().userInterfaceIdiom == .Phone
        }
    }
}