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
//import CoreLocation
class API_Model {
    
//        let _apiUrl = "http://insight.touch-ics.com/_develop/public/api/v1/"
//        let _oldapiUrl = "http://api.touch-ics.com/_develop/2.2/interface/insight"
//        let _uploadAPI = "http://api.touch-ics.com/_develop/2.2/uploadmedia/"
    
//    let _apiUrl = "http://192.168.9.58/framework/public/api/v1/"
//    let _oldapiUrl = "http://192.168.9.58/api/interface/insight"
//    let _uploadAPI = "http://192.168.9.58/api/uploadmedia/"
    
    let _apiUrl = "http://192.168.9.118/framework/public/api/v1/"
    let _oldapiUrl = "http://192.168.9.118/api/interface/insight"
    let _uploadAPI = "http://192.168.9.118/api/uploadmedia/"
    
    
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
    func getFromServer(apiName:String,completionHandler:[String:AnyObject]->())
    {
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

//        print("data All \(param)")
        Alamofire.request(.POST, "\(_oldapiUrl)", parameters: param,encoding: .JSON)
            .responseJSON { response in
                //                print(response.request)  // original URL request
                //                print(response.response) // URL response
                //                print(response.data)     // server data
                //                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    //print("JSON: \(JSON)")
                    if let jsonStatus = (JSON["status"])
                    {
                        //print("jsonStatus :\(JSON["status"] as! Int)")
                        if (jsonStatus as! Int == 4051){
                            print("Error")
                        }else
                        {
                            let result = self.deCrypt(JSON["data"] as! String, base64IV: IV_Key64)
                            //print("============================================")
                            
//                            print("before JsonEncode : \(result)")
                            //completionHandler(JSON as! [String : AnyObject])
                            let resultJson = self.jsonEncode(result as String)
//                            print("resultJson")
//                            print(resultJson)
//                            print("= = = = = = = =")
                            completionHandler(resultJson )
//                            print("after JsonEncode : \(resultJson)")
//                            print("Result===> : \(resultJson["ListProviderInformationSummary"])")
                        }
                    }

                    
                }
                
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
                    if let jsonStatus = (JSON["status"])
                    {
                        print("jsonStatus :\(JSON["status"] as! Int)")
                        if (jsonStatus as! Int == 4051){
                            print("Error")
//                            print("Data \(self.deCrypt(JSON["data"] as! String, base64IV: IV_Key64))")
                            print("Message \(JSON["message"])")
                        }else
                        {
                            let result = self.deCrypt(JSON["data"] as! String, base64IV: IV_Key64)
                            print("============================================")
                            let resultJson = self.jsonEncode(result as String)
                            completionHandler(resultJson )
                        }
                    }
                    
                    
                }
                
        }
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
        Alamofire.request(.POST, reqUrl, parameters: parameters)
            .responseJSON { response in
                print("---------------------------------------------------------------------")
                print("Login")
//                print(response.request)  // original URL request
                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
                print("---------------------------------------------------------------------")
//                print("Code \(response.response?.valueForKey("status code") as! String)")
                if let JSON = response.result.value {
                    print("JSON(Login): \(JSON)")
                    
                    if let error = JSON["errors"]
                    {
                        var data: [String:AnyObject] = [:]
                        if let code = JSON["code"]{
                            print("code : : \(code)")
                            if code == nil{
                                data["status"] = true
                                data["userID"] = (JSON["userId"] as! String)
//                                data["accessToken"] = JSON["accessToken"]
//                                print("accessToken : \(JSON["accessToken"] as! String)")
                                self.appDelegate.userInfo["accessToken"] = (JSON["accessToken"] as! String)
                                self.appDelegate.userInfo["userID"] = (JSON["userId"] as! String)
                                self.appDelegate.userInfo["passWord"] = password
                                print("Login(User ID) \(JSON["userId"]!)")
                                Alamofire.request(.GET, "\(self._apiUrl)users/\(JSON["userId"] as! String)/avatars", parameters: ["": ""])
                                    .responseJSON { response in
//                                        print(response.request)  // original URL request
//                                        print(response.response) // URL response
//                                        print(response.data)     // server data
//                                        print(response.result)   // result of response serialization
                                        
                                        if let JSON = response.result.value {
//                                            print("JSON avatar login : \(JSON["small"])")
                                            self.appDelegate.userInfo["avatarImage"] = (JSON["small"] as! String)
                                        }
                                }
//                                print("userID\(JSON["userId"] as! String)")
//                                self.getUserInfo(JSON["userId"] as! String)
//                                print("success")
                            }else{
                                data["status"] = false
                            }
                        }

                        for var index = 0 ;index < error?.count ;index++
                        {
                            print("field\(index) \(error![index]["field"] as! String)")
                            if (error![index]["field"] as! String) == "username"
                            {
                                data["field"] = error![index]["field"]
                                data["message"] = "username ไม่มีในระบบ"
                            }else if (error![index]["field"] as! String) == "password"
                            {
                                data["field"] = error![index]["field"]
                                data["message"] = "password ผิด"
                            }
                            
                        }
                        completionHandler(data)
                    }
                }
        }
    }

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
                            }else{
                                data["status"] = false
                            }
                        }
//                        for var index = 0 ;index < error?.count ;index++
//                        {
//                            print("errors \(error![index]["field"] as! String)")
//                        }
                        for var index = 0 ;index < error?.count ;index++
                        {
//                            print("field\(index) \(error![index]["field"] as! String)")
                            if (error![index]["field"] as! String) == "email"
                            {
                                data["field"] = error![index]["field"]
                                data["message"] = "email ซ้ำในระบบ"
                            }
                            
                        }

                        completionHandler(data)
                    }
                    
                    
                    //                        print("username : \(JSON["email"] as! String)")
                }
                
                
        }
    }
    func CreateUserAvatar(userID:String,image:UIImage, completionHandler:[String:AnyObject]->())
    {
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        var data = [String:AnyObject]()
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
//        var manager = Manager.sharedInstance
//        manager.session.configuration.HTTPAdditionalHeaders = ["Content-Type": "image/png"]
        print("base64String : \(base64String)")
        
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
                    
                    if let error = JSON["errors"]{
                        var data: [String:AnyObject] = [:]
                        if let code = JSON["code"]{
                            print("code : : \(code)")
                            if code == nil{
                                data["status"] = true
                            }else{
                                data["status"] = false
                            }
                        }
                        for var index = 0 ;index < error?.count ;index++
                        {

                            
                        }
                        
                        completionHandler(data)
                    }
                }
                
                
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
                    let data = [
                        "profileName" : (JSON["firstName"] as! String)+" "+(JSON["lastName"] as! String),
                        "email"       : (JSON["email"] as! String)
                    ]
                    self.appDelegate.userInfo["firstName"] = (JSON["firstName"] as! String)
                    self.appDelegate.userInfo["lastName"] = (JSON["lastName"] as! String)
                    self.appDelegate.userInfo["profileName"] = (JSON["firstName"] as! String)+" "+(JSON["lastName"] as! String)
                    self.appDelegate.userInfo["email"] = (JSON["email"] as! String)
                    self.appDelegate.userInfo["mobile"] = (JSON["phoneNumber"] as! String)
                    self.appDelegate.userInfo["id"] = (JSON["id"] as! String)
                    
                    
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
                        completionHandler("OK")
                        debugPrint(response)
                        
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })

    }
    func uploadImageArray(mediaKey:String,image:[UIImage],imageName:String,completionHandler:String->())
    {
        print("Media Key : \(mediaKey)")
        let parameters = [
            "file": ""
        ]
        
        let API_URL = "http://192.168.9.58/api/uploadmedia/\(mediaKey)"
        
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
//            print("Json Encode \(jsonResult! as NSDictionary)")
            return jsonResult! as NSDictionary
//            return (jsonResult! as! [String : AnyObject])
//            print("ListProviderInformationSummary : \(jsonResult!["ListProviderInformationSummary"])")
        } catch let error as NSError {
            print(error)
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
    
    /////////////////////Hotel Room/////////////////
    
//    func
    
}