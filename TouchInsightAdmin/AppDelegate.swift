//
//  AppDelegate.swift
//  TouchInsightAdmin
//
//  Created by weerapons suwanchatree on 11/25/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    let viewWithTopButtons = UIView()
    var window: UIWindow?
    let osVersion = UIDevice.currentDevice().systemVersion
    let UUID = UIDevice.currentDevice().identifierForVendor!.UUIDString
    var latitude: String = "0.00"
    var longitude: String = "0.00"
    var accessToken: String?
    var providerData:NSDictionary?
    var providerIDData:NSDictionary?
    var provinceDic:NSDictionary?
    var isLogin = Bool()
    
    //Hotel
    var facilityHotelDic:NSDictionary?
    var facilityHotelStatus = [Bool]()
    var hotelLogo = UIImageView()
//    var facilitiesHotelAttached = [String]()
    
    //Room
    var roomIndex : Int?
    var roomGalleryIndex : Int?
    var roomDic:NSDictionary?
    var facilityRoomDic:NSDictionary?
    var facilityRoomStatus = [Bool]()
    
    //Province
    var provinceName = [String]()
    var provinceID = [String]()
    
    //provider
    var alertProvider : CustomIOS7AlertView?
    var pagecontrolIndex : Int?
    var providerIndex:Int?
    var command = [
        "createProvider":"010600",
        "listProvider":"010100",
        "updateProvider":"010700",
        //Room
        "listRoom":"090100",
        "ListGallery" : "070100",
        "createRoomType":"090600",
        "UpdateRoomType":"090700",
        "DeleteRoomType" : "090800",
        "SetRoomTypeFacilityAttached":"120700",
        "GetRoomTypeFacilityAttached":"120100",
        "ListRoomTypeGallery" : "100100",
        "CreateRoomTypeGallery":"100600",
        
        "getUploadImageURL":"010700",
        "listProvince":"000300",
        "ListHotelFacility":"110001",
        "SetFacilityAttached":"110700",
        "GetFacilityAttached":"110100",
        "ListRoomFacility":"120001",
        "GetProviderInformationById":"010200",
        "CreateGallery" : "070600"
        
    ]
    var userInfo = [
        "userID":"",
        "avatarImage":"",
        "profileName:":"",
        "firstName":"",
        "lastName":"",
        "email":"",
        "accessToken":"",
        "mobile":"",
        "passWord":"",
        "id":""
    ]
   

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
      return true
        
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        //return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        return true
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        //FBSDKAppEvents.activateApp()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    


}

