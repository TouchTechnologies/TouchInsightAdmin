//
//  ViewController.swift
//  TouchInsightAdmin
//
//  Created by weerapons suwanchatree on 11/25/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import Alamofire
//import ObjectMapper
//import AlamofireObjectMapper


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func gogogo(sender: AnyObject) {
        
        let headers = [
            "X-Parse-REST-API-Key":"sqfSdSWsRtZFCvMtYuPo3Rjum72wceAW4Jyan2Zp",
            "X-Parse-Application-Id":"lxPvvAlKnkn7xS4mUAuPyxEBhAMTh4JYYKOCYV6P",
            "Content-Type":"application/json",
            ]
        
        // Add URL parameters
        let urlParams = [
            "":"{\"username\":{\"$in\":[\"tak\"]},\"password\":{\"$in\":[\"1234\"]}}",
            "where":"{\"username\":{\"$in\":[\"tak\"]}}",
            ]
        
        // Fetch Request
        Alamofire.request(.GET, "https://parseapi.back4app.com/classes/member", headers: headers, parameters: urlParams)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.data)")
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
        
    }

    
    

}


