//
//  alertCreateProviderV.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/21/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import SCLAlertView
class alertCreateProviderV: UIView , UITableViewDelegate , UITableViewDataSource ,UITextFieldDelegate{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let typename : [String] = ["Attraction","Restaurant","Hotel"]
    let typeimg : [String] = ["ic_attraction","ic_restaurant","ic_hotel"]
    let typeimghover : [String] = ["ic_attraction_hover","ic_restaurant_hover","ic_hotel_hover"]
    var typeKeyName:String?
    var currentSelectStatus = [false,false,false]
    
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var providerNameTxt: UITextField!
    var  cell = providerCell()
    var alertsuccess = SCLAlertView()
    
    
    var btnsuccess = UIButton()
    
    var rowH = CGFloat()
    var iphonescx = CGFloat()
    var iphonescy = CGFloat()
    func initialSize(){
        iphonescy = (736.0/480.0);
        iphonescx = (414.0/320.0);
        
        
        if(UI_USER_INTERFACE_IDIOM() == .Pad){
            
            //rowH = 70*scy
        }
        else{
            
            rowH = 70
        }
        
        
    }
    
    //    func customIOS7AlertViewButtonTouchUpInside(alertView: CustomIOS7AlertView, buttonIndex: Int) {
    //        print("reload")
    //        alertView.close()
    //       // tableView.reloadData()
    //    }
    @IBAction func createBtn(sender: AnyObject) {
        let send = API_Model()
        // var titleMessage:String = ""
        var message:String = "Information"
        //        if self.typeKeyName == typename[2]
        //        {
        //            let dataJson =
        //            [
        //                "providerInformation" :
        //                    [
        //                        "providerTypeKeyname" : self.typeKeyName!,
        //                        "nameEn"              :providerNameTxt.text!,
        //                        "nameTh"              : ""
        //                    ],
        //                "user" :
        //                    [
        //                        "accessToken" : self.appDelegate.userInfo["accessToken"]!
        //                    ]
        //            ]
        //
        //            //create Provider
        //            send.providerAPI(self.appDelegate.command["createProvider"]!, dataJson: send.Dict2JsonString(dataJson)){
        //                data in
        //                //                    print("data :\(data)")
        //
        //               let dataJsonUpdate = "{\"providerUser\":\"\(self.appDelegate.userInfo["email"]!)\"}"
        //              //  print("appDelegate :\(self.appDelegate.userInfo["email"])")
        //                                 print("dataSendJson : \(dataJsonUpdate)")
        //                //
        //                send.providerAPI(self.appDelegate.command["listProvider"]!, dataJson: dataJsonUpdate){
        //                    data in
        //
        //                    //                        print("listProvider :\(data["ListProviderInformationSummary"]!)")
        //                    self.appDelegate.providerData = data
        //                    print("Count: \(self.appDelegate.providerData!["ListProviderInformationSummary"]!.count)")
        //
        ////                    message = "Info"
        //                self.alertsuccess.addButton("OK", action: {
        //                        print ("Success")
        //
        //                        self.providerNameTxt.text = ""
        //
        //                        self.tableView.reloadData()
        //                        self.removeFromSuperview()
        //
        //
        //                    })
        //                self.alertsuccess.showCloseButton = false
        //                self.alertsuccess.showCircularIcon = false
        //                self.alertsuccess.showInfo(message, subTitle: "Create provider success!", closeButtonTitle:nil, duration:1.0, colorStyle:0xAC332F)
        //                }
        //
        //            }
        //        }
        //        else
        //        {
        //
        //            message = "Information"
        //            let alertfail = SCLAlertView()
        //            alertfail.showCircularIcon = false
        //            alertfail.showInfo(message, subTitle: "Create provider fail!", colorStyle:0xAC332F)
        //                print("nil")
        //        }
        
        let dataJson =
            [
                "providerInformation" :
                    [
                        "providerTypeKeyname" : self.typeKeyName!,
                        "nameEn"              :providerNameTxt.text!,
                        "nameTh"              : ""
                ],
                "user" :
                    [
                        "accessToken" : self.appDelegate.userInfo["accessToken"]!
                ]
        ]
        
        //create Provider
        send.providerAPI(self.appDelegate.command["createProvider"]!, dataJson: send.Dict2JsonString(dataJson)){
            data in
            //                    print("data :\(data)")
            
            let dataJsonUpdate = "{\"providerUser\":\"\(self.appDelegate.userInfo["email"]!)\"}"
            //  print("appDelegate :\(self.appDelegate.userInfo["email"])")
            print("dataSendJson : \(dataJsonUpdate)")
            //
            send.providerAPI(self.appDelegate.command["listProvider"]!, dataJson: dataJsonUpdate){
                data in
                
                //                        print("listProvider :\(data["ListProviderInformationSummary"]!)")
                self.appDelegate.providerData = data
                print("Count: \(self.appDelegate.providerData!["ListProviderInformationSummary"]!.count)")
                
                //                    message = "Info"
                self.alertsuccess.addButton("OK", action: {
                    print ("Success")
                    
                    self.providerNameTxt.text = ""
                    
                    self.tableView.reloadData()
                    self.removeFromSuperview()
//                    let provList = ProviderListVC()
//                    provList.alertDismiss(UIButton())
                    
                })
                self.alertsuccess.showCloseButton = false
                self.alertsuccess.showCircularIcon = false
                self.alertsuccess.showInfo(message, subTitle: "Create provider success!", closeButtonTitle:nil, duration:5.0, colorStyle:0xAC332F)
            }
            
        }
        
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSize()
        
        UIView.animateWithDuration(0.5, animations: {}, completion: {_ in
            self.providerNameTxt.becomeFirstResponder()
        })
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return typename.count
        return 3
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.providerNameTxt.resignFirstResponder()
        
        print(" Index Path : \(indexPath.row)")
        typeKeyName = typename[indexPath.row]
        print("Key : \(typename[indexPath.row])")
        cell = tableView.dequeueReusableCellWithIdentifier("Cell"  , forIndexPath: indexPath) as! providerCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        //    if(typename[indexPath.row] == "Attraction"){
        //    cell.selected = false
        //    }
        //    else if(typename[indexPath.row] == "Restaurant"){
        //            cell.selected = false
        //    }
        
        for i in 0...currentSelectStatus.count-1 {
            currentSelectStatus[i] = false
        }
        
        if currentSelectStatus[indexPath.row] != true {
            
            currentSelectStatus[indexPath.row] = true
        }else{
            
            currentSelectStatus[indexPath.row] = false
        }
        
        print(currentSelectStatus[indexPath.row])
        print(currentSelectStatus)
        tableView.reloadData()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let nib = UINib(nibName:"providerTypeCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
        cell = tableView.dequeueReusableCellWithIdentifier("Cell" , forIndexPath: indexPath) as! providerCell
        if(indexPath.row == 0 && indexPath.row == 1){
            cell.providerImg.alpha = 0.5
            cell.providerTypeLbl.alpha = 0.5
            cell.setSelected(false, animated: true)
        }
        
        
        var imgName = ""
        var rowColor = UIColor()
        if currentSelectStatus[indexPath.row] != true {
            imgName = self.typeimg[indexPath.row]
            rowColor = UIColor.grayColor()
        }else{
            imgName = self.typeimghover[indexPath.row]
            rowColor = UIColor.blackColor()
        }
        
        cell.providerImg.image = UIImage(named:imgName)
        cell.providerTypeLbl.text = self.typename[indexPath.row]
        cell.providerTypeLbl.textColor = rowColor
        cell.setSelected(true, animated: true)
        
        return cell
    }
    func tableView(tableView: UITableView,didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.allowsMultipleSelection = false
    }
    //    
    //    func textFieldShouldReturn(textField: UITextField) -> Bool {
    //        textField.resignFirstResponder()
    //        return true
    //        
    //    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowH
    }
    
}
