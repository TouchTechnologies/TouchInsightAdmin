//
//  API_Model.swift
//  TouchInsightAdmin
//
//  Created by weerapons suwanchatree on 11/26/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import Foundation
import Alamofire
import RNCryptor
import SwiftyJSON
import RealmSwift

//import CoreLocation
class API_Model {
    
//    let _apiUrl = "http://partner.seeitlivethailand.com/api/v1/"
//    let _oldapiUrl = "http://api.touch-ics.com/2.2/interface/insight"
//    let _uploadAPI = "http://api.touch-ics.com/2.2/uploadmedia/"
    
    let _apiUrl = "http://192.168.1.118/framework/public/api/v1/"
    let _oldapiUrl = "http://192.168.1.118/api/interface/insight"
    let _uploadAPI = "http://192.168.1.118/api/uploadmedia/"
    
    
//    let _apiUrl = "http://27.254.47.203:8094/backend_api/interface/insight/"
//    let _oldapiUrl = "http://27.254.47.203:8094/backend_api/interface/insight"
//    let _uploadAPI = "http://api.touch-ics.com/2.2/uploadmedia/"
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let _osVersion = UIDevice.currentDevice().systemVersion
    let _UUID = UIDevice.currentDevice().identifierForVendor!.UUIDString
    let _SecretKey = "BcILclihFSTbm3tGpfKfrbdW"
    
    func post2Server(apiName:String,POST_Data:[String:AnyObject],completionHandler:[String:AnyObject]->()){
        Alamofire.request(.GET, "\(_apiUrl)\(apiName)", parameters: POST_Data)
            .responseJSON { response in
                //                print(response.request)  // original URL request
                //                print(response.response) // URL response
                //                print(response.data)     // server data
                //                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    completionHandler(JSON as! [String : AnyObject])
                    
                }
                
        }
    }
    
    func getFromServer(apiName:String,completionHandler:[String:AnyObject]->()){
        Alamofire.request(.GET, "\(_apiUrl)\(apiName)")
            .responseJSON { response in
                //                print(response.request)  // original URL request
                //                print(response.response) // URL response
                //                print(response.data)     // server data
                //                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let data = [
                        "firstName":JSON["firstName"],
                        "lastName" :JSON["lastName"]
                    ]
                    self.appDelegate.userInfo["firstName"] = (JSON["firstName"] as! String)
                    self.appDelegate.userInfo["lastName"] = (JSON["lastName"]as! String)
                    completionHandler(data as! [String : AnyObject])
                    
                }
                
        }
    }
    
    func oldPostData(apiName:String,POST_Data:[String:AnyObject],completionHandler:[String:AnyObject]->()){
        Alamofire.request(.POST, "\(_oldapiUrl)", parameters: POST_Data,encoding: .JSON)
            .responseJSON { response in
                //                print(response.request)  // original URL request
                //                print(response.response) // URL response
                //                print(response.data)     // server data
                //                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    //print("JSON: \(JSON)")
                    completionHandler(JSON as! [String : AnyObject])
                    
                }
                
        }
    }
    func providerAPI(apiCode:String,dataJson:String,completionHandler:NSDictionary->()){
        
        //        print("dataJson \(dataJson)")
        let IV_Key64 = "XVVdXHhYU2A="
        let data = enCrypt(dataJson, base64IV: IV_Key64)
        let param: [String:AnyObject] = [
            "appName": "touchinsightmobileapp",
            "client": "touchinsightmobileapp",
            "appVersion": "1.0",
            "OSVersion": _osVersion,
            "deviceID": _UUID,
            "command": apiCode,
            "OS": "iOS",
            "mobileAgent": appDelegate.mobileAgent,
            "language": "TH",
            "mask": IV_Key64,
            "data": data
        ]
        
//        //        print("data All \(param)")
//        Alamofire.request(.POST, "\(_oldapiUrl)", parameters: param,encoding: .JSON)
//            .responseJSON { response in
//                //                print(response.request)  // original URL request
//                //                print(response.response) // URL response
//                //                print(response.data)     // server data
//                //                print(response.result)   // result of response serialization
//                
//                if let JSON = response.result.value {
//                    //                    print("providerAPIJSON: \(JSON)")
//                    if let jsonStatus = (JSON["status"])
//                    {
//                        //print("jsonStatus :\(JSON["status"] as! Int)")
//                        if (jsonStatus as! Int == 4051){
//                            print("Error")
//                        }else{
//                            let result = self.deCrypt(JSON["data"] as! String, base64IV: IV_Key64)
//                            //print("============================================")
//                            
//                            //                            print("before JsonEncode : \(result)")
//                            //completionHandler(JSON as! [String : AnyObject])
//                            let resultJson = self.jsonEncode(result as String)
//                            //                            print("resultJson")
//                            //                            print(resultJson)
//                            //                            print("= = = = = = = =")
//                            print("providerAPIJSON: \(resultJson)")
//                            completionHandler(resultJson )
//                            //                            print("after JsonEncode : \(resultJson)")
//                            //                            print("Result===> : \(resultJson["ListProviderInformationSummary"])")
//                        }
//                    }
//                    
//                    
//                }
//                
//        }
        
        
        
        print("------- print param value -------")
        print(param)
        print("------------------------------------")
        
        
        let request = Alamofire.request(.POST, String(_oldapiUrl), parameters: param, encoding: .JSON, headers: .None)
        request.validate()
        request.responseJSON{ response in
            //                print(response.request)  // original URL request
            //                print(response.response) // URL response
            //                print(response.data)     // server data
            //                print(response.result)   // result of response serialization
            
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
//                    print("------- print test data value -------")
//                    print(value)
//                    print("------------------------------------")
//                    
//                    print("------- print test data json -------")
//                    print(json)
//                    print("------------------------------------")
                    
                    let jsonStatus = json["status"].intValue
                    
                    print("------- jsonStatus = \"\(jsonStatus)\" -------")
                    if (jsonStatus == 4051){
                        print("Error")
                    }else{
                        
                        
                        
                        let strData = json["data"].stringValue
                        print("---->>> json[data].stringValue <<<-----")
                        print(strData)
                        
                        if let result = (self.deCrypt(strData, base64IV: IV_Key64)) as NSString?{
                        
                            //print("============================================")
                            
                            //                            print("before JsonEncode : \(result)")
                            //completionHandler(JSON as! [String : AnyObject])
                            if let resultJson = self.jsonEncode(result as String) as NSDictionary? {
                            
                                //                            print("resultJson")
                                //                            print(resultJson)
                                //                            print("= = = = = = = =")
                                
                                print("---->>>provider APIJSON<<<-----")
                                print(dataJson)
                                print("-------------------------------")
                                print(result)
                                print("||||>>>provider APIJSON<<<||||")
                                
                                completionHandler(resultJson )
                                //                            print("after JsonEncode : \(resultJson)")
                                //                            print("Result===> : \(resultJson["ListProviderInformationSummary"])")
                                
                            }else{
                                
                                completionHandler(NSDictionary() )
                                
                            }
                            
                        }else{
                            
                            completionHandler(NSDictionary() )
                        
                        }
                        
                    }
                    
//                    if let jsonStatus = json["status"]{
//                        //print("jsonStatus :\(JSON["status"] as! Int)")
//                        if (jsonStatus as! Int == 4051){
//                            print("Error")
//                        }else{
//                            let result = self.deCrypt(json["data"].stringValue, base64IV: IV_Key64)
//                            //print("============================================")
//                            
//                            //                            print("before JsonEncode : \(result)")
//                            //completionHandler(JSON as! [String : AnyObject])
//                            let resultJson = self.jsonEncode(result as String)
//                            //                            print("resultJson")
//                            //                            print(resultJson)
//                            //                            print("= = = = = = = =")
//                            
//                            print("---->>>provider APIJSON<<<-----")
//                            print(dataJson)
//                            print("-------------------------------")
//                            print(result)
//                            print("||||>>>provider APIJSON<<<||||")
//                            
//                            completionHandler(resultJson )
//                            //                            print("after JsonEncode : \(resultJson)")
//                            //                            print("Result===> : \(resultJson["ListProviderInformationSummary"])")
//                        }
//                    }else{
//                    
//                    }
                    
                }

                break
            case .Failure( _):
                
                print("--- Error ---")
//                print(error)
                break
            }
            
            
//            if let JSON = response.result.value {
//                //                    print("providerAPIJSON: \(JSON)")
//                if let jsonStatus = (JSON["status"])
//                {
//                    //print("jsonStatus :\(JSON["status"] as! Int)")
//                    if (jsonStatus as! Int == 4051){
//                        print("Error")
//                    }else{
//                        let result = self.deCrypt(JSON["data"] as! String, base64IV: IV_Key64)
//                        //print("============================================")
//                        
//                        //                            print("before JsonEncode : \(result)")
//                        //completionHandler(JSON as! [String : AnyObject])
//                        let resultJson = self.jsonEncode(result as String)
//                        //                            print("resultJson")
//                        //                            print(resultJson)
//                        //                            print("= = = = = = = =")
//                        
//                        print("---->>>provider APIJSON<<<-----")
//                        print(dataJson)
//                        print("-------------------------------")
//                        print(result)
//                        print("||||>>>provider APIJSON<<<||||")
//                        
//                        completionHandler(resultJson )
//                        //                            print("after JsonEncode : \(resultJson)")
//                        //                            print("Result===> : \(resultJson["ListProviderInformationSummary"])")
//                    }
//                }
//                
//                
//            }
        }
    }
    func getProvince(apiCode:String,dataJson:String,completionHandler:NSDictionary->()){
        
        //print("dataJson \(dataJson)")
        let IV_Key64 = "XVVdXHhYU2A="
        let data = enCrypt(dataJson, base64IV: IV_Key64)
        let param: [String:AnyObject] = [
            "appName": "touchinsightmobileapp",
            "client": "touchinsightmobileapp",
            "appVersion": "1.0",
            "OSVersion": _osVersion,
            "deviceID": "359359052323687",
            "command": "000300",
            "OS": "iOS",
            "mobileAgent": "samsung/t03gxx/t03g:4.4.2/KOT49H/N7100XXUFNI4:user/release-keys",
            "language": "TH",
            "mask": IV_Key64,
            "data": data
        ]
        
        //print("data All \(param)")
        Alamofire.request(.POST, "\(_oldapiUrl)", parameters: param,encoding: .JSON)
            .responseJSON { response in
                //                print(response.request)  // original URL request
                //                print(response.response) // URL response
                //                print(response.data)     // server data
                //                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    if let jsonStatus = (JSON["status"]){
                        print("jsonStatus :\(JSON["status"] as! Int)")
                        if(jsonStatus as! Int == 4051){
                            print("Error")
                            //                            print("Data \(self.deCrypt(JSON["data"] as! String, base64IV: IV_Key64))")
                            print("Message \(JSON["message"])")
                        }else{
                            let result = self.deCrypt(JSON["data"] as! String, base64IV: IV_Key64)
                            print("============================================")
                            let resultJson = self.jsonEncode(result as String)
                            completionHandler(resultJson )
                        }
                    }
                }
        }
    }
    
    private func GetUserTokenByID22222(userID:String,completionHandler:String->()){
        
        let parameters = [
            "platform":"Application",
            "tokenIdentifier":_UUID,
            "os":"iOS",
            ]
        let reqUrl = "\(_apiUrl)users/\(userID)/tokens"
        
        print("reqUrl : \(reqUrl)")
        print("parameters : \(parameters)")
        
        let request = Alamofire.request(.POST, reqUrl, parameters: parameters, encoding: .JSON, headers: .None)
        //request.validate()
        request.responseJSON{response in
            
            print("response xxxxx : \(response)")
            
            var returnData = ""
            if response.result.isSuccess {
                
                if let json = response.result.value {
                    
                    print("json xxxxx : \(json)")
                    
                    if json["accessToken"] != nil && !(json["accessToken"] is NSNull){
                        if let accessToken = json["accessToken"] as! String? {
                            returnData = accessToken
                        }
                    }
                }else{
                    returnData = ""
                }
                
            }else{
                returnData = ""
            }
            
            print("GetUserTokenByID")
            print(returnData)
            print("- - - - - -")
            
            completionHandler(returnData)
            
        }
    }

    
    func GetToken(completionHandler:String->()){
        
        //let userID = self.appDelegate.userInfo["userID"]!
        let username = self.appDelegate.userInfo["username"]!
        let password = self.appDelegate.userInfo["passWord"]!
        
        let parameters = [
            "platform":"Application",
            "tokenIdentifier":_UUID,
            "os":"iOS",
            "username": username,
            "password": password,
            ]
        let reqUrl = "\(_apiUrl)tokens"
        
        print("reqUrl : \(reqUrl)")
        print("parameters : \(parameters)")
        
        let request = Alamofire.request(.POST, reqUrl, parameters: parameters, encoding: .JSON, headers: .None)
        //request.validate()
        request.responseJSON{response in
            
            var returnData:String = ""
            if response.result.isSuccess {
                if let json = response.result.value as! NSDictionary? {
                    returnData = json["accessToken"]! as! String
                    
                    self.appDelegate.userInfo["accessToken"] = returnData
                    
                    // - - - - -
                    let newMember = MemberData()
                    newMember.id = self.appDelegate.userInfo["id"]!
                    newMember.userID = self.appDelegate.userInfo["userID"]!
                    newMember.avatarImage = self.appDelegate.userInfo["avatarImage"]!
                    newMember.firstName = self.appDelegate.userInfo["firstName"]!
                    newMember.lastName = self.appDelegate.userInfo["lastName"]!
                    newMember.profileName = self.appDelegate.userInfo["profileName"]!
                    newMember.mobile = self.appDelegate.userInfo["mobile"]!
                    newMember.email = self.appDelegate.userInfo["email"]!
                    newMember.username = self.appDelegate.userInfo["username"]!
                    newMember.passWord = self.appDelegate.userInfo["passWord"]!
                    newMember.accessToken = self.appDelegate.userInfo["accessToken"]!
                    
                    print("newMember rrr : \(newMember)")
                    
                    try! uiRealm.write{
                        uiRealm.add(newMember)
                        print("write Yes")
                        
                    }
                    // - - - - -
                    
                    
                    self.appDelegate.isLogin = true
                    
                }
            }else{
                
                returnData = "\(response.result.error?.localizedDescription)"
                
            }
            
            print("GetToken returnData")
            print(returnData)
            print("- - - - - -")
            
            completionHandler(returnData)
            
        }
        
    }
    
    
    func checkToken(userData:Object,completionHandler:String->()){
        
        var returnData = ""
        
        print("userData")
        print(userData)
        print("- - - - - -")
        
        let _accessToken = userData["accessToken"]! as! String
        //let userID = userData["userID"]! as! String
        
        if(_accessToken != ""){
            
            
            let reqUrlToken = "\(_apiUrl)tokens/\(_accessToken)" // "\(self._apiUrl)users/\(userID)/avatars" //
            print("reqUrlToken = \(reqUrlToken)")
            
            Alamofire.request(.GET, reqUrlToken).responseJSON { response in
                
                print(response)
                
                if response.result.isSuccess {
                    
                    if let json = response.result.value {
                        let _data = JSON(json)
                        returnData = String(_data["accessToken"])
                        
                    }
                    print("Success")
                }else{
                    
                    print("error")
                    print(response.result.error?.localizedDescription)
                    print(response.result.value)
                    
                }
                
                
                //completionHandler(data)
            }
            
            
        }else{
//            self.GetUserTokenByID(userID, completionHandler: {tk in
//                returnData = tk as String
//            })
        }
        
        print("GetUserDataByID")
        print(returnData)
        print("- - - - - -")
        
        completionHandler(returnData)
        
    }
    
    func sendRequest(url: String, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionTask {
        
        let requestURL = NSURL(string:"\(url)")!
        
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler:completionHandler)
        task.resume()
        
        return task
    }

    func LogIn(username:String,password:String,latitude:String,longitude:String,completionHandler:[String:AnyObject]->())
    {
        let parameters = [
            "username":username,
            "password":password,
            "tokenIdentifier":_UUID,
            "platform":"Application",       //Fix
            "os":"iOS",                     //Fix
            "osVersion":_osVersion,
            "expire":"",
            "latitude": latitude,
            "longitude":longitude
        ]
        
        print("UUID : \(_UUID)")
        print("latitude: \(latitude)")
        print("longitude: \(longitude)")
        print("parameter \(parameters)")
        let reqUrl = "\(_apiUrl)tokens"
        print(reqUrl)
        
        let request = Alamofire.request(.POST, reqUrl, parameters: parameters, encoding: .JSON, headers: .None)
        //request.validate()
        request.responseJSON{response in
            
            var returnData: [String:AnyObject] = [:]
//            var returnData: [String:AnyObject] = [
//                "success":false,
//                "message":"Cannot Connect to Server!",
//                "data":[]
//            ]
        
            //print("JSON(Login)")
            print(response.result.value)
        
            if response.result.isSuccess {
                
                if let json = response.result.value {
                    
                    if let userId = json["userId"] as! String? { // Login OK
                        //print("userId = \(userId)")
                        
                        returnData = [
                            "success":true,
                            "message":"Login Success!",
                            "data":json
                        ]
                        
                        //data["userID"] = userId
                        self.appDelegate.userInfo["accessToken"] = (json["accessToken"] as! String)
                        self.appDelegate.userInfo["userID"] = (json["userId"] as! String)
                        self.appDelegate.userInfo["passWord"] = password
                        //print("Login(User ID) \(JSON["userId"]!)")
                        Alamofire.request(.GET, "\(self._apiUrl)users/\(userId)/avatars", parameters: ["":""])
                            .responseJSON { response in
                                if let json = response.result.value {
                                    let _data = JSON(json)
                                    print("JSON avatar login : \(_data["small"])")
                                    print("JSON : \(_data)")
                                    self.appDelegate.userInfo["avatarImage"] = String(_data["small"])
                                    print("self.appDelegate.userInfo ccxcvsd = \((self.appDelegate.userInfo as Dictionary))")
                                    
                                }
                        }
                        
                    }else{
                        
                        var msg = ""
                        if let error = json["errors"] as! NSArray?{
                            
                            if let message = error[0]["message"] as! NSArray?{
                                
                                for msgError in message{
                                    msg = msgError as! String
                                    print(msgError)
                                    print("-------")
                                }
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                        returnData = [
                            "success":false,
                            "message":msg,
                            "data":json
                        ]
                    }
                }
                
                //print("Success")
            }else{
                
                returnData = [
                    "success":false,
                    "message":"Cannot Connect to Server!",
                    "data":[:]
                ]
                
                print("error")
                print(response.result.error?.localizedDescription)
                print(response.result.value)
                
            }
            
            print("returnData")
            print(returnData)
            print("- - - - - -")
            
            completionHandler(returnData)
            
        }
    }
    //http://localhost/api/v1/users/:userId/social-accounts
    
    func Register(firstName:String,lastName:String,mobile:String,email:String,passWord:String,completionHandler:[String:AnyObject]->())
    {
        let parameters = [
            "username": email,
            "email": email,
            "displayName": "",
            "password": passWord,
            "firstName": firstName,
            "lastName": lastName,
            "phoneNumber": mobile,
            "avatar":"",
            "activeStatus":"active"
        ]
        Alamofire.request(.POST, "\(_apiUrl)users", parameters: parameters)
            .responseJSON { response in
                
                if let JSON = response.result.value {
                    
                    print("JSON(Regis): \(JSON)")
                    //                    print("code \(JSON["code"] as! Int)")
                    //                    print("message \(JSON["message"] as! String)")
                    
                    
                    if let error = JSON["errors"]{
                        var data: [String:AnyObject] = [:]
                        if let code = JSON["code"]{
                            print("code : : \(code)")
                            if code == nil{
                                data["status"] = true
                                data["data"] = JSON
                            }else{
                                data["status"] = false
                            }
                        }
                        //                        for var index = 0 ;index < error?.count ;index++
                        //                        {
                        //                            print("errors \(error![index]["field"] as! String)")
                        //                        }
                        //for index in 0..<error!.count {
                        
                        for index in 0...(error!.count - 1) {
                            print("I'm number \(index)")
                            if (error![index]["field"] as! String) == "email"
                            {
                                data["field"] = error![index]["field"]
                                data["message"] = "email ซ้ำในระบบ"
                            }
                        }
                        
                        
//                        for var index = 0 ;index < error?.count ;index += 1 {
//                            //                            print("field\(index) \(error![index]["field"] as! String)")
//                            if (error![index]["field"] as! String) == "email"
//                            {
//                                data["field"] = error![index]["field"]
//                                data["message"] = "email ซ้ำในระบบ"
//                            }
//                            
//                        }
                        
                        
//                        for index in 0..<error!.count {
//                            print(index)
//                        }
                        
                        completionHandler(data)
                    }
                    
                    
                    //                        print("username : \(JSON["email"] as! String)")
                }
                
                
        }
    }
    func CreateUserAvatar(userID:String,image:UIImage, completionHandler:[String:AnyObject]->())
    {
//        let imageData = UIImageJPEGRepresentation(image, 0.5)
        var data = [String:AnyObject]()
//        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        let base64String = image.toBase64()
        
        //        var manager = Manager.sharedInstance
        //        manager.session.configuration.HTTPAdditionalHeaders = ["Content-Type": "image/png"]
        //print("base64String : \(base64String)")
        
        let URL = NSURL(string: "\(_apiUrl)users/\(userID)/avatars?encoding=base64")!
        
        Alamofire.request(.POST, URL, parameters: ["encoding": "base64"], encoding: .Custom({
            (convertible, params) in
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            mutableRequest.HTTPBody = base64String.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            
            data["status"] = true
            completionHandler(data)
            return (mutableRequest, nil)
        }))
        
    }
    func updateUser(firstName:String,lastName:String,mobile:String,email:String,passWord:String,completionHandler:[String:AnyObject]->())
    {
        let parameters = [
            "username": email,
            "email": email,
            "displayName": "",
            "password": passWord,
            "firstName": firstName,
            "lastName": lastName,
            "phoneNumber": mobile,
            "avatar":"",
            "activeStatus":"active"
        ]
        print("param : \(parameters)")
        print("userID : \(appDelegate.userInfo["userID"]!)")
        print("ID : \(appDelegate.userInfo["id"]!)")
        
        Alamofire.request(.PATCH, "\(_apiUrl)users/\(appDelegate.userInfo["userID"]!)", parameters: parameters,encoding: .JSON)
            .responseJSON { response in
                
                if let JSON = response.result.value {
                    
                    print("JSON(userUpdate): \(JSON)")
                    //                    print("code \(JSON["code"] as! Int)")
                    //                    print("message \(JSON["message"] as! String)")
                    
                    if (JSON["errors"]) != nil{
                        var data: [String:AnyObject] = [:]
                        if let code = JSON["code"]{
                            print("code : : \(code)")
                            if code == nil{
                                data["status"] = true
                            }else{
                                data["status"] = false
                            }
                        }
                        
//                        for index in 0..<error!.count {
//                            print(index)
//                        }
                        
//                        for( var index = 0 ;index < error?.count ;index += 1){
//                            
//                            
//                        }
                        
                        completionHandler(data)
                    }
                }
                
                
        }
    }
    //users/:userId/social-accounts
    func LogInFB(userID:String,socialAccessToken:String,completionHandler:[String:AnyObject]->())
    {
        let parameters = [
//            "userId":"facebook",
            "accessToken":socialAccessToken,
            "social":"facebook"             //Fix
        ]
        print("parameter \(parameters)")
        let reqUrl = "\(_apiUrl)users/\(userID)/social-accounts"
        print(reqUrl)
        
        let request = Alamofire.request(.POST, reqUrl, parameters: parameters, encoding: .JSON, headers: .None)
        //request.validate()
        request.responseJSON{response in
            
            var returnData: [String:AnyObject] = [:]
            //            var returnData: [String:AnyObject] = [
            //                "success":false,
            //                "message":"Cannot Connect to Server!",
            //                "data":[]
            //            ]
            
            print("JSON(LogInFB)")
            print(response.result.value)
            
            if response.result.isSuccess {
                
                if let json = response.result.value {
                    
                    if let userId = json["userId"] as! String? { // Login OK
                        //print("userId = \(userId)")

                        let parametersFB = [
                            //            "userId":"facebook",
                            "tokenIdentifier":self._UUID,
                            "platform":"Application",//Fix
                            "os":"iOS"              //Fix
                        ]
                        print("parameter \(parametersFB)")
                        let reqUrlFB = "\(self._apiUrl)users/\(userId)/tokens"
                        let request = Alamofire.request(.POST, reqUrlFB, parameters: parametersFB, encoding: .JSON, headers: .None)
                        //request.validate()
                        request.responseJSON{response in
                            
                            print("JSON(getFBTocken)")
                            print(response.result.value)
                            
                            
                            
                        }
                        returnData = [
                            "success":true,
                            "message":"Login Success!",
                            "data":json
                        ]
                        
                        self.appDelegate.userInfo["accessToken"] = (json["accessToken"] as! String)
                        self.appDelegate.userInfo["userID"] = (json["userId"] as! String)
//                        self.appDelegate.userInfo["passWord"] = password
                        //print("Login(User ID) \(JSON["userId"]!)")
                        Alamofire.request(.GET, "\(self._apiUrl)users/\(userId)/avatars", parameters: ["":""])
                            .responseJSON { response in
                                if let JSON = response.result.value {
                                    print("JSON avatar login : \(JSON["small"]!)")
                                    self.appDelegate.userInfo["avatarImage"] = (JSON["small"] as! String)
                                }
                        }

                    }else{ // Login Fail
                        //print("userId = NO")
                        //print(json["errors"]!![0]["message"]!![0])
                        
                        //if let _m = (json["errors"] as! Array)[0]["message"]!![0] as! String{
                        
                        //                        for var index = 0 ;index < error?.count ;index++
                        //                        {
                        //                            print("field\(index) \(error![index]["field"] as! String)")
                        //                            if (error![index]["field"] as! String) == "username"
                        //                            {
                        //                                data["field"] = error![index]["field"]
                        //                                data["message"] = "username ไม่มีในระบบ"
                        //                            }else if (error![index]["field"] as! String) == "password"
                        //                            {
                        //                                data["field"] = error![index]["field"]
                        //                                data["message"] = "password ผิด"
                        //                            }
                        //
                        //                        }
                        
                        var msg = ""
                        if let error = json["errors"] as! NSArray?{
                            
                            if let message = error[0]["message"] as! NSArray?{
                                
                                for msgError in message{
                                    msg = msgError as! String
                                    print(msgError)
                                    print("-------")
                                }
                                
                                //                                if let _m = message[0]{
                                //                                    msg = _m
                                //                                }
                                
                                //                                if(message.count > 0){
                                //                                    if let _m = message[0] as! String?{
                                //                                        msg = _m
                                //                                    }
                                //
                                //                                }
                            }
                            
                            
                            
                        }
                        
                        
                        
                        returnData = [
                            "success":false,
                            "message":msg,
                            "data":json
                        ]
                    }
                }
                
                //print("Success")
            }else{
                
                returnData = [
                    "success":false,
                    "message":"Cannot Connect to Server!",
                    "data":[:]
                ]
                
                print("error")
                print(response.result.error?.localizedDescription)
                print(response.result.value)
                
            }
            
            print("returnData")
            print(returnData)
            print("- - - - - -")
            
            completionHandler(returnData)
            
        }
    }
    func checkUser(email:String, completionHandler:[String:AnyObject]->())
    {
        
        let parameters = [
            "username":email,
            "email":email
        ]
        var data = [String:AnyObject]()
        let reqUrl = "\(_apiUrl)users"
        print("parameter \(parameters)")
        print(reqUrl)
//        let request = Alamofire.request(.GET, reqUrl, parameters: parameters, encoding: .JSON, headers: .None)
//        //request.validate()
//        request.responseJSON{response in
        
        Alamofire.request(.GET, "\(_apiUrl)users?username=\(email)") // เช็คว่่มี User นี้อยู่ใน DB หรือยัง
                .responseJSON { response in
            
                if let json = response.result.value {
                    let _data = JSON(json)
                    print("JSON(checkUser): \(_data)")
                    
                    if(_data.count > 0){
                        print("check user with email : Exists")
                        data["status"] = false
                        data["data"] = json[0]
                    }else{
                        print("check user with email : No exists")
                        data["status"] = true
                        data["data"] = ""
                    }
                }
                    
            completionHandler(data)
        }
    }

    func checkUserFB(id:String, completionHandler:[String:AnyObject]->())
    {
        var data = [String:AnyObject]()
        
        Alamofire.request(.GET, "\(_apiUrl)users/\(id)/social-accounts")
            .responseJSON { response in
                //            print(response.request)  // original URL request
                //            print(response.response) // URL response
                //            print(response.data)     // server data
                //            print(response.result)   // result of response serialization
                
                
                if let JSON = response.result.value {
                    //print("JSON(checkUserFB): \(JSON)")
                    if(JSON.count == 0){
                        //print("NULLLLLL")
                        data["status"] = true
                        data["data"] = ""
                    }else{
                        data["status"] = false
                        data["data"] = JSON[0]
                    }
                    
                    
                }
                completionHandler(data)
        }
    }

    func getUserInfo(userID:String, completionHandler:[String:AnyObject]->())
    {
        Alamofire.request(.GET, "\(_apiUrl)users/\(userID)")
            .responseJSON { response in
                //                print(response.request)  // original URL request 
                //                print(response.response) // URL response
                //                print(response.data)     // server data
                //                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON(user Info): \(JSON)")
                    
//                    var data: [String:AnyObject] = [:]
//                    data["profileName"] = "\((JSON["firstName"] as! String)) \((JSON["lastName"] as! String))"
                    
//                    let data:[String:AnyObject] = [
//                        "profileName": "\((JSON["firstName"] as! String)) \((JSON["lastName"] as! String))",
//                        "firstName": (JSON["firstName"] as! String),
//                        "lastName": (JSON["lastName"] as! String),
//                        "email": (JSON["email"] as! String),
//                        "mobile": (JSON["phoneNumber"] as! String),
//                        "id": (JSON["id"] as! String),
//                        "userId": (JSON["id"] as! String),
//                        "avatarImage": (JSON["avatar"] as! String),
//                        "username": (JSON["username"] as! String)
//                    ]
                    
                    
//                    self.appDelegate.userInfo["firstName"] = (JSON["firstName"] as! String)
//                    self.appDelegate.userInfo["lastName"] = (JSON["lastName"] as! String)
//                    self.appDelegate.userInfo["profileName"] = (JSON["firstName"] as! String)+" "+(JSON["lastName"] as! String)
//                    self.appDelegate.userInfo["email"] = (JSON["email"] as! String)
//                    self.appDelegate.userInfo["mobile"] = (JSON["phoneNumber"] as! String)
//                    self.appDelegate.userInfo["id"] = (JSON["id"] as! String)
                    let data:[String:AnyObject] = (JSON as! [String:AnyObject])
                    
                    //                    print("proFileName(getUserInfo) :\(self.appDelegate.userInfo["profileName"])")
                    completionHandler(data)
                }
                
        }
    }
    
    func getUploadKey(providerID:Int,imageType:String,imageName:String,completionHandler:String->())
    {
        let dataJson = [
            "providerInformation" : [
                "providerId": providerID
            ],
            "medias" : [
                imageType : [
                    "filename": imageName
                ]
            ],
            "user" : [
                "accessToken" : self.appDelegate.userInfo["accessToken"]!
            ]
        ]
        
        print("JsonData(getUploadKey) : \(dataJson)")
        print("Dict2JsonString : \(Dict2JsonString(dataJson))")
        //get ImageURL
        providerAPI(self.appDelegate.command["getUploadImageURL"]!, dataJson: Dict2JsonString(dataJson)){
            data in
            //            print("data(getImageURL) :\(data)")
            print("key : \(data["mediaKey"]!)")
            completionHandler(data["mediaKey"] as! String)
            
        }
    }
    
    func getUploadMenuKey(providerID:Int,menuID:Int,imageType:String,imageName:String,completionHandler:String->())
    {
        let dataJson = [
            "providerInformation" : [
                "providerId": providerID
            ],
            "menu" : [
                "menuId" : menuID
            ],
            "medias" : [
                imageType : [
                    "filename": imageName
                ]
            ],
            "user" : [
                "accessToken" : self.appDelegate.userInfo["accessToken"]!
            ]
        ]
        
        print("JsonData(getUploadKey) : \(dataJson)")
        print("Dict2JsonString : \(Dict2JsonString(dataJson))")
        //get ImageURL
        providerAPI(self.appDelegate.command["getUploadMenuImageURL"]!, dataJson: Dict2JsonString(dataJson)){
            data in
            //            print("data(getImageURL) :\(data)")
            print("key : \(data["mediaKey"]!)")
            completionHandler(data["mediaKey"] as! String)
            
        }
    }
    func getGallery(providerID:Int,completionHandler:[[String:AnyObject]]->())
    {
        
        let dataJson = [
            "providerInformation" : [
                "providerId": providerID
            ],
            "page" : [
                "offset": 0,
                "limit": 30
            ]
        ]
        
        providerAPI(self.appDelegate.command["ListGallery"]!, dataJson: Dict2JsonString(dataJson)){
            data in
            print("data() :\(data)")
            print("data(Count) :\(data["gallery"]!.count)")
            completionHandler(data["gallery"] as! [[String : AnyObject]])
            
            
        }
    }
    func getUploadKeyGallery(providerID:String,imageName:String,completionHandler:String->())
    {
        
        let dataJson = [
            "providerInformation" : [
                "providerId": providerID
            ],
            "gallery" : [[
                "medias" : [
                    "image": [
                        "filename" : imageName
                    ]
                ]
                ]],
            "user" : [
                "accessToken" : self.appDelegate.userInfo["accessToken"]!
            ]
        ]
        
        print("JsonData(getUploadKeyGallery) : \(dataJson)")
        print("Dict2JsonString : \(Dict2JsonString(dataJson))")
        //get ImageURL
        providerAPI(self.appDelegate.command["CreateGallery"]!, dataJson: Dict2JsonString(dataJson)){
            data in
            //            print("data(getImageURL) :\(data)")
            //            print("CreateGallery key : \(data["mediaKey"]!)")
            completionHandler(data["mediaKey"] as! String)
            
        }
    }
    func getRoomGallery(roomID:String,completionHandler:[[String:AnyObject]]->())
    {
        
        let dataJson = [
            "roomType" : [
                "roomTypeId": roomID
            ],
            "page" : [
                "offset": 0,
                "limit": 30
            ]
        ]
        
        providerAPI(self.appDelegate.command["ListRoomTypeGallery"]!, dataJson: Dict2JsonString(dataJson)){
            data in
            print("RoomID :\(roomID)")
            print("data(All) :\(data)")
            print("data(Count) :\(data["roomTypeGallery"]!.count)")
            completionHandler(data["roomTypeGallery"] as! [[String : AnyObject]])
            
            
        }
    }
    
    func getMenuGallery(MenuID:String,completionHandler:[[String:AnyObject]]->())
    {
        
        let dataJson = [
            "menu" : [
                "menuId": MenuID
            ],
            "page" : [
                "offset": 0,
                "limit": 30
            ]
        ]
        
        providerAPI(self.appDelegate.command["ListRoomTypeGallery"]!, dataJson: Dict2JsonString(dataJson)){
            data in
            print("data(All) :\(data)")
            print("data(Count) :\(data["roomTypeGallery"]!.count)")
            completionHandler(data["roomTypeGallery"] as! [[String : AnyObject]])
            
            
        }
    }
    func getUploadKeyRoomGallery(RoomID:Int,imageName:String,completionHandler:String->())
    {
        let dataJson = [
            "roomType" : [
                "roomTypeId": RoomID
            ],
            "roomTypeGallery" : [[
                "medias" : [
                    "image": [
                        "filename" : imageName
                    ]
                ]
                ]],
            "user" : [
                "accessToken" : self.appDelegate.userInfo["accessToken"]!
            ]
        ]
        
        //print("JsonData : \(dataJson)")
        //get ImageURL
        providerAPI(self.appDelegate.command["CreateRoomTypeGallery"]!, dataJson: Dict2JsonString(dataJson)){
            data in
            print("data(getUploadKeyRoomGallery) :\(data)")
            print("key : \(data["mediaKey"]!)")
            completionHandler(data["mediaKey"] as! String)
            
        }
    }
    func getUploadKeyMenuGallery(MenuID:Int,imageName:String,completionHandler:String->())
    {
        let dataJson = [
            "menu" : [
                "menuId": MenuID
            ],
            "menuGallery" : [[
                "medias" : [
                    "image": [
                        "filename" : imageName
                    ]
                ]
                ]],
            "user" : [
                "accessToken" : self.appDelegate.userInfo["accessToken"]!
            ]
        ]
        
        //print("JsonData : \(dataJson)")
        //get ImageURL
        providerAPI(self.appDelegate.command["CreateMenuGallery"]!, dataJson: Dict2JsonString(dataJson)){
            data in
            print("data(getUploadKeyMenuGallery) :\(data)")
            print("key : \(data["mediaKey"]!)")
            completionHandler(data["mediaKey"] as! String)
            
        }
    }
    
    func uploadImage(mediaKey:String,image:UIImage,imageName:String,completionHandler:String->())
    {
        print("Media Key : \(mediaKey)")
        let parameters = [
            "file": ""
        ]
        
        //        let _uploadAPI = "http://192.168.9.58/api/uploadmedia/"
        let API_URL = _uploadAPI+mediaKey
        print("UPload AI URL : \(API_URL)")
        //        let API_URL = "http://192.168.9.58/api/uploadmedia/\(mediaKey)"
        
        Alamofire.upload(.POST, API_URL, multipartFormData: {
            multipartFormData in
            
            if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                multipartFormData.appendBodyPart(data: imageData, name: "\(mediaKey)[]", fileName: imageName, mimeType: "image/png")
            }
            
            for (key, value) in parameters {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            
            }, encodingCompletion: {
                encodingResult in
                
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        print("=====================================")
                        print(response)
                        completionHandler("OK")
                        debugPrint(response)
                        
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })
        
//        .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
//                print("\(totalBytesWritten) / \(totalBytesExpectedToWrite)")
//        }
        
    }
    func uploadImageArray(mediaKey:String,image:[UIImage],imageName:String,completionHandler:String->())
    {
        print("Media Key : \(mediaKey)")
        let parameters = [
            "file": ""
        ]
        
//        let API_URL = "http://192.168.9.58/api/uploadmedia/\(mediaKey)"
        let API_URL = _uploadAPI
        
        Alamofire.upload(.POST, API_URL, multipartFormData: {
            multipartFormData in
            
            
            for index in 0...image.count-1
            {
                if let imageData = UIImageJPEGRepresentation(image[index], 0.5) {
                    multipartFormData.appendBodyPart(data: imageData, name: "\(mediaKey)[]", fileName: imageName, mimeType: "image/png")
                }
            }
            
            
            
            for (key, value) in parameters {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            
            }, encodingCompletion: {
                encodingResult in
                
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        print("=====================================")
                        completionHandler("OK")
                        debugPrint(response)
                        
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })
        
    }
    
    func deCrypt(base64Data:String,base64IV:String)->NSString
    {
        let decodedData = NSData(base64EncodedString:base64Data, options:NSDataBase64DecodingOptions(rawValue: 0) )
        
        //        print("==================================")
        
        let IV_KEY:NSData = NSData(base64EncodedString: base64IV, options:NSDataBase64DecodingOptions(rawValue: 0) )!
        //        print("IV Key : \(IV_KEY)")
        let IV_STRING = NSString(data: IV_KEY, encoding: NSUTF8StringEncoding)
        let IV_Byte = [UInt8]((IV_STRING as! String).utf8)
        
        //        print("==================================")
        //        print("Decode Data : \(decodedData! as NSData)") // my plain data
        //        print("decodedData?.length \((decodedData?.length)! as Int)")
        let mydata_len : Int = ((decodedData?.length)! as Int)
        let keyData : NSData = ("BcILclihFSTbm3tGpfKfrbdW").dataUsingEncoding(NSUTF8StringEncoding)!
        //init
        let buffer_size : size_t = mydata_len+kCCBlockSize3DES
        let buffer = UnsafeMutablePointer<NSData>.alloc(buffer_size)
        var num_bytes_encrypted : size_t = 0
        let operation: CCOperation = UInt32(kCCDecrypt)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = UInt32(kCCOptionPKCS7Padding)
        let keyLength        = size_t(kCCKeySize3DES)
        //Decrypt
        let decrypt_status : CCCryptorStatus = CCCrypt(operation, algoritm,options, keyData.bytes, keyLength,IV_Byte, decodedData!.bytes, mydata_len, buffer, buffer_size, &num_bytes_encrypted)
        
        if UInt32(decrypt_status) == UInt32(kCCSuccess){
            
            let myResult : NSData = NSData(bytes: buffer, length: num_bytes_encrypted)
            free(buffer)
            //            print("decrypt \(myResult)")
            
            let stringResult = NSString(data: myResult, encoding:NSUTF8StringEncoding)
            //            print("my decrypt string : \(stringResult!)")
            jsonEncode(stringResult as! String)
            //            return myResult
            return stringResult!
        }else{
            free(buffer)
            return ""
            
        }
        
    }
    func enCrypt(data:String,base64IV:String)->String
    {
        
        
        print("============================================")
        
        let myKeyData : NSData = ("BcILclihFSTbm3tGpfKfrbdW" as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        let myRawData : NSData = data.dataUsingEncoding(NSUTF8StringEncoding)!
        //        var base64RawData = myRawData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        //        print("RawData :\(myRawData)")
        //        print("RawDataBase64 :\(base64RawData)")
        //        var iv : [UInt8] = [56, 101, 63, 23, 96, 182, 209, 205]  // I didn't use
        
        let IV_KEY:NSData = NSData(base64EncodedString: base64IV, options:NSDataBase64DecodingOptions(rawValue: 0) )!
        //        print("IV Key : \(IV_KEY)")
        let IV_STRING = NSString(data: IV_KEY, encoding: NSUTF8StringEncoding)
        let IV_Byte = [UInt8]((IV_STRING as! String).utf8)
        
        
        let buffer_size : size_t = myRawData.length + kCCBlockSize3DES
        let buffer = UnsafeMutablePointer<NSData>.alloc(buffer_size)
        var num_bytes_encrypted : size_t = 0
        
        let operation: CCOperation = UInt32(kCCEncrypt)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = UInt32(kCCOptionPKCS7Padding)
        //        let mode : CCMode   = UInt32(kCCModeCBC)
        let keyLength        = size_t(kCCKeySize3DES)
        let Crypto_status: CCCryptorStatus = CCCrypt(operation, algoritm,options, myKeyData.bytes, keyLength,IV_Byte , myRawData.bytes, myRawData.length, buffer, buffer_size, &num_bytes_encrypted)
        //======================================================
        
        
        
        
        //===========================================================
        //        var Crypto_status: CCCryptorStatus = CCCrypt(operation, algoritm, options, myKeyData.bytes, keyLength, nil, myRawData.bytes, myRawData.length, buffer, buffer_size, &num_bytes_encrypted)
        
        if UInt32(Crypto_status) == UInt32(kCCSuccess){
            
            let myResult: NSData = NSData(bytes: buffer, length: num_bytes_encrypted)
            
            free(buffer)
            //            print("my result \(myResult)") //This just prints the data
            
            //            let keyData: NSData = myResult
            // let hexString = keyData.toHexString()
            // print("hex result \(hexString)") // I needed a hex string output
            
            let base64Send = myResult.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            //            let secretData: NSData = "BcILclihFSTbm3tGpfKfrbdW".dataUsingEncoding(NSUTF8StringEncoding)!
            //            let SecretBase64 = secretData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            
            //            print("Secret: \(SecretBase64)")
            //            print("Data Send \(base64Send)")
            //            SendData = base64Send
            //            myDecrypt(myResult) // sent straight to the decryption function to test the data output is the same
            return base64Send
        }else{
            free(buffer)
            return ""
        }
    }
    
    func jsonEncode(jsonString:String)->NSDictionary
    {
        
        let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            //print("Json Encode \(jsonResult! as NSDictionary)")
            return jsonResult! as NSDictionary
            //return (jsonResult! as! [String : AnyObject])
            //print("ListProviderInformationSummary : \(jsonResult!["ListProviderInformationSummary"])")
        } catch let error as NSError {
            print(error)
            let error = [
                "error":"error"
            ]
            return error
        } catch {
            let error = [
            "error":"error"
            ]
            return error
        }
        
    }
    
    func Dict2JsonString(dict:[String:AnyObject])->String{
        do {
            let jsonResults = try NSJSONSerialization.dataWithJSONObject(dict, options: [])
            //            print("jsonResults :\(jsonResults)")
            // success ...
            let json = NSString(data: jsonResults, encoding: NSUTF8StringEncoding)
            if let jsonString = json {
                //print("JsonString :\(json)")
                //                print("JsonEncode :\(jsonEncode(jsonString as String))")
                return jsonString as String
                
            }
        } catch {
            // failure
            print("Fetch failed: \((error as NSError).localizedDescription)")
            //            return "{\"status\":}"
        }
        
        return "{\"status\":}"
    }
    func createProvider(data:[String:AnyObject])
    {
        //        
        //        let dataJson1 = "{\"providerInformation\":{\"providerTypeKeyname\":\"\(data["providerTypeKeyname"]!)\",\"nameEn\":\"\(data["nameEn"]!)\",\"nameTh\":\"\(data["nameTh"]!)\"},\"user\":{\"accessToken\": \"\(appDelegate.userInfo["accessToken"]!)\"}}"
        //        print("Create Provider \(data)")
        let providerInformation = [
            "providerTypeKeyname" : data["providerTypeKeyname"]!,
            "nameEn"              : data["nameEn"]!,
            "nameTh"              : data["nameTh"]!
        ]
        let user = [
            "accessToken" : appDelegate.userInfo["accessToken"]!
        ]
        let dataJson = [
            "providerInformation" : Dict2JsonString(providerInformation),
            "user" : Dict2JsonString(user)
        ]
        
        let dataaaa = Dict2JsonString(dataJson)
        print("last Json String : \(Dict2JsonString(dataJson))")
        //        var newString = convertDict2Json(dataJson).stringByReplacingOccurrencesOfString("\"{", withString: "{")
        //        newString = newString.stringByReplacingOccurrencesOfString("}\"", withString: "}")
        print("new  : \(dataaaa)")
        //        print("data1: \(dataJson1)")
        print("JsonEncode : \(jsonEncode(dataaaa))")
        providerAPI("010600", dataJson: dataaaa){
            data in
            print(data["data"])
        }
        //        print("Json \(dataJson)")
    }
    func listProvider(providerUser:String)
    {
        let dataJson = "{\"providerUser\":\"weerapon\"}"
        
        providerAPI("010100", dataJson: dataJson){
            data in
            print("listProvider :\(data["ListProviderInformationSummary"]!.count)")
            //            return data
        }
        
    }
    
    /////////////////////Coupon API/////////////////
    func getCoupon(providerID:String,completionHandler:[[String:AnyObject]]->()) {
        
        //let app = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let reqUrl = "\(_apiUrl)coupon-groups"
        print("reqUrl = \(reqUrl)")
        
        let body = [
            //"page":"1",
            //"perpage":"4",
            //"providerId":"6688",
            //"q":"pro",
            "sort": "-createdAt"
        ]
        
        Alamofire.request(.GET, reqUrl, headers: nil, parameters: body, encoding: .URL)
            
            //.validate(statusCode: 200..<300)
            .responseJSON { response in
                var arrReturnCoupon = [[String : AnyObject]]()
                if response.result.isSuccess
                {
                    print("response.result.value")
                    print(response.result.value)
                    //                print("response : : : \(response.result.value as! NSArray)")
                    if let arrJson = response.result.value as! NSArray? {
                        
                        var arrTmps = [[String : AnyObject]]()
                        
                        if (arrJson.count > 0){
                            
                            //                            print("userID = \(String(self.appDelegate.userInfo["userID"]!))")
                            //                            print("providerID = \(providerID)")
                            //                            print("- - - - - - - - - - - - - - - - - - - - -")
                            
                            let userID = String(self.appDelegate.userInfo["userID"]!) // self.appDelegate.userInfo["userID"]! as! String
                            
                            var n:Int = 0
                            for dictItem in arrJson {
                                
                                
                                //let _id = dictItem["id"] as! String
                                let _createdBy = dictItem["createdBy"] as! String
                                let _providerId = dictItem["providerId"] as! String
                                
                                //                                print("dictItem->id = \(_id)")
                                //                                print("dictItem->createdBy = \(_createdBy)")
                                //                                print("dictItem->providerId = \(_providerId)")
                                //                                print("= = = = = = = = =")
                                
                                if((_createdBy == userID) && (_providerId == providerID)){
                                    
                                    print(dictItem)
                                    
                                    //                                    print("= = = = = = = = =")
                                    //                                    print("dictItem->id = \(String(dictItem["id"]!))")
                                    //                                    print("dictItem->createdBy = \(String(dictItem["createdBy"]!))")
                                    //                                    print("dictItem->providerId = \(String(dictItem["providerId"]!))")
                                    //                                    print("= = = add ss = = =")
                                    
//                                    if let dicToObject = dictItem as! Dictionary? {
//                                        
//                                        
//                                    }
                                    
                                    arrTmps.insert(dictItem as! [String : AnyObject], atIndex: n)
                                    
                                    n = n + 1
                                    
                                }
                                
                                //                                print("= = = = = = = = = = = = = = = = = = = = = = = = = = =")
                                
                                //arrTmps.addObject(dictItem as! [String : AnyObject])
                                
                            }
                        }
                        
                        arrReturnCoupon = arrTmps
                        
                        print("- - - - arrReturnCoupon - - - -")
                        print(arrReturnCoupon)
                        print("-------------------------------")
                        
                        completionHandler(arrReturnCoupon)
                        //completionHandler(arrJson as! [[String : AnyObject]])
                    }else{
                        print("WTF ELSE")
                        
                        completionHandler(arrReturnCoupon)
                    }
                }
        }
    }
    
    func getCouponByID(couponID:String!,completionHandler:[String:AnyObject]->()) {
        
        let reqUrl = "\(_apiUrl)coupon-groups/\(couponID)"
        print("reqUrl = \(reqUrl)")
        
        Alamofire.request(.GET, reqUrl, headers: nil, parameters: [:], encoding: .URL)
            
            .responseJSON { response in
                var dicReturnCoupon = NSDictionary()
                if response.result.isSuccess {
                    if let dicJson = response.result.value as! NSDictionary? {
                        dicReturnCoupon = dicJson
                        completionHandler(dicReturnCoupon as! [String : AnyObject])
                    }else{
                        completionHandler(dicReturnCoupon as! [String : AnyObject])
                    }
                }
        }
        
    }
    
    func createCoupon(data:[String:AnyObject],completionHandler:[String:AnyObject]->())
    {
        let reqUrl = "\(_apiUrl)coupon-groups"
        let request = Alamofire.request(.POST, reqUrl, parameters: data, encoding: .JSON, headers: .None)
        //request.validate()
        request.responseJSON{response in
            var returnData: [String:AnyObject] = [:]
            if response.result.isSuccess {
                if let json = response.result.value {
                    if let jsonDic = json as? NSDictionary {
                        if let errors = jsonDic["errors"] as? NSArray where errors.count > 0 {
                            var msgError = "something went wrong\nplease try again later!"
                            if let arrError = errors[0]["message"] as? NSArray {
                                if let strError = arrError[0] as? String {
                                    msgError = strError
                                }
                            }
                            returnData = [
                                "success":false,
                                "message":msgError,
                                "data":jsonDic
                            ]
                        }else{
                            returnData = [
                                "success":true,
                                "message":"Insert Coupon Success!",
                                "data":jsonDic
                            ]
                        }
                    }
                }
            }else{
                returnData = [
                    "success":false,
                    "message":"Cannot Connect to Server!",
                    "data":[:]
                ]
                //                print("error")
                //                print(response.result.error?.localizedDescription)
                //                print(response.result.value)
            }
            completionHandler(returnData)
        }
    }
    
    func uploadCouponImage(data:[String:AnyObject],completionHandler:[String:AnyObject]->()){
        
        //let couponID = (data["id"]!).stringValue
        let couponID = String(data["id"]!)
        let base64String = String(FileMan().resizeImage((data["image"]! as! UIImage), maxSize: 500).toBase64())
        
        let reqUrl = "\(_apiUrl)coupon-groups/\(couponID)/banners?encoding=base64"
        var data = [String:AnyObject]()
        
        //print("id header = \(data["id"]!)")
        //print("id data = \(data["id"]!)")
        print("reqUrlUploadImage = \(reqUrl)")
        
        let headers = [
            "Content-Type":"image/png",
            ]
        
        Alamofire.request(.POST, reqUrl, parameters: ["encoding": "base64"], encoding: .Custom({
            (convertible, params) in
            
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            mutableRequest.HTTPBody = base64String.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            
            data["status"] = true
            completionHandler(data)
            return (mutableRequest, nil)
        }), headers: headers)
        
//        Alamofire.request(.POST, reqUrl, parameters: ["encoding": "base64"], encoding: .Custom({
//            (convertible, params) in
//            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
//            mutableRequest.HTTPBody = base64String.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
//            
//            data["status"] = true
//            completionHandler(data)
//            return (mutableRequest, nil)
//        }))
    }
    
    
    func uploadFileCouponImage(data:[String:AnyObject],image:UIImage,completionHandler:Bool->()){
        
        //let couponID = (data["id"]!).stringValue
        let providerID = String(data["providerID"]!)
        let couponID = String(data["couponID"]!)
        let imgData = image
        
        //let base64String = String(FileMan().resizeImage((data["image"]! as! UIImage), maxSize: 500).toBase64())
        
        //        let reqUrl = "\(_apiUrl)coupon-groups/\(couponID)/banners?encoding=base64"
        //        var data = [String:AnyObject]()
        
        //print("id header = \(data["id"]!)")
        //print("id data = \(data["id"]!)")
        //print("reqUrlUploadImage = \(reqUrl)")
        
        let headers = [
            "Content-Type":"image/png",
            ]
        
        //let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        //let imgData = UIImage(named: "icon-2.png")!
        //let base64String = imgData.toBase64()
        let base64String = String(FileMan().resizeImage(imgData, maxSize: 500).toBase64())
        //let imgData = UIImagePNGRepresentation(FileMan().resizeImage(imgData, maxSize: 500))
        
        let imgName = "\(randomStringWithLength(10)).png"
        let resUpload = "\(_apiUrl)files/hotel/\(providerID)/coupon/\(couponID)/\(imgName)?encoding=base64"
        print("resUpload : \(resUpload)")
        
        let URL = NSURL(string: resUpload)!
        
        Alamofire.request(.POST, URL, parameters: [:], encoding: .Custom({
            (convertible, params) in
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            mutableRequest.HTTPBody = base64String.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            let returnData:Bool = true
            completionHandler(returnData)
            return (mutableRequest, nil)
        }), headers: headers)
        
    }
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyz0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        if(len>0){
            for (_) in 0...len{
                let length = UInt32 (letters.length)
                let rand = arc4random_uniform(length)
                randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
            }
        }else{
            randomString = "x"
        }
        
        return randomString
    }
    
    
}