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
        if NSProcessInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 8, minorVersion: 0, patchVersion: 0)) { //println("iOS >= 8.0.0")
            return UIScreen.mainScreen().traitCollection.userInterfaceIdiom == .Pad
        }else{
            return (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        }
    }
    
    public class var isIphone:Bool {
        if NSProcessInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 8, minorVersion: 0, patchVersion: 0)) { //println("iOS >= 8.0.0")
            return UIScreen.mainScreen().traitCollection.userInterfaceIdiom == .Phone
        }else{
            return UIDevice.currentDevice().userInterfaceIdiom == .Phone
        }
    }
}