//
//  CreateRoomInfoVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/9/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import PKHUD
class EditRoominfomationVC:
    UIViewController,
    UITextFieldDelegate,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UITableViewDataSource,
    UITableViewDelegate,
    UIScrollViewDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate ,
    UIGestureRecognizerDelegate,
    CustomIOS7AlertViewDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let send = API_Model()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    var facilitiesRoomAttached = [String]()
    var roomCollection = [UIImage]()
//    var mediaKey:String?
    var roomImage = [UIImageView()]
    var roomGallery = [UIImage()]
    var roomImageUpload = [UIImage()]
    var roomImageNum = 0
    var pickerType = ""
    var occupencyNum = Int32()
    var addImageNum = 1
    
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var facilityView: UIView!
    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet weak var roomNameTxt: UITextField!
    @IBOutlet weak var shotDescTxt: UITextView!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var numOfRoomTxt: UITextField!
    @IBOutlet weak var bedTxt: UITextField!
    @IBOutlet weak var maxOccupTxt: UITextField!
    var navunderlive = UIView()
    var width = CGFloat()
    var height = CGFloat()
    
    var Cell = RoomGalleryCell()
    
    @IBAction func plusOccupency(sender: AnyObject) {
        print("+1")
        occupencyNum = occupencyNum + 1
        maxOccupTxt.text = "\(occupencyNum)"
    }
    
    @IBAction func minusOccupency(sender: AnyObject) {
        if(occupencyNum <= 1){
        
            occupencyNum = 1
        }
        else{
            occupencyNum = occupencyNum-1
        }
        
        maxOccupTxt.text = "\(occupencyNum)"
        
    }
    override func viewWillAppear(animated: Bool) {
        let width = UIScreen.mainScreen().bounds.size.width
        let contentscrollheight = self.scrollView.layer.bounds.size.height
        scrollView.contentSize = CGSizeMake(width,contentscrollheight+300);
        self.navigationController?.setNavigationBarHidden(false, animated: true)
       // let contentscrollheight = self.scrollView.layer.bounds.size.height
       
       
        
        
        print("room index : \(appDelegate.roomIndex)")
        print("RoomID :  \(appDelegate.roomDic!["roomTypes"]![appDelegate.roomIndex!]!["room_type_id"] as! String)")
    //    print("Edit room \(appDelegate.roomDic!["roomTypes"]![appDelegate.roomIndex!])")
        roomNameTxt.text = (appDelegate.roomDic!["roomTypes"]![appDelegate.roomIndex!]!["room_type_name_en"] as! String)
        shotDescTxt.text = (appDelegate.roomDic!["roomTypes"]![appDelegate.roomIndex!]!["room_type_description_en"] as! String)
        priceTxt.text = (appDelegate.roomDic!["roomTypes"]![appDelegate.roomIndex!]!["room_type_current_price"] as! String)
        
        numOfRoomTxt.text = (appDelegate.roomDic!["roomTypes"]![appDelegate.roomIndex!]!["room_type_description_th"] as! String)
        bedTxt.text = (appDelegate.roomDic!["roomTypes"]![appDelegate.roomIndex!]!["room_type_current_price"] as! String)
        maxOccupTxt.text = (appDelegate.roomDic!["roomTypes"]![appDelegate.roomIndex!]!["maximum_person"] as! String)
        occupencyNum = Int32(maxOccupTxt.text!)!
        self.appDelegate.viewWithTopButtons.hidden = true
        self.getFacility()
        
//        self.setFacility(7270)
//        self.updateData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.getRoomGallery()
        roomNameTxt.delegate = self
        priceTxt.delegate = self
        bedTxt.delegate = self
        maxOccupTxt.delegate = self
        numOfRoomTxt.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        roomGallery.removeAll()
        roomImageUpload.removeAll()
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
//        occupencyNum = 1
//        maxOccupTxt.text = "\(occupencyNum)"
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view!.addGestureRecognizer(tap)
        
        self.initNavUnderline()
        self.initialObject()
         }
    func initialObject(){
        
        roomNameTxt.borderStyle = UITextBorderStyle.RoundedRect
        roomNameTxt.layer.cornerRadius = 5
        roomNameTxt.layer.borderWidth = 1
        roomNameTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor

        shotDescTxt.layer.cornerRadius = 5
        shotDescTxt.layer.borderWidth = 1
        shotDescTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.2).CGColor
        
        priceTxt.borderStyle = UITextBorderStyle.RoundedRect
        priceTxt.layer.cornerRadius = 5
        priceTxt.layer.borderWidth = 1
        priceTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        
        numOfRoomTxt.borderStyle = UITextBorderStyle.RoundedRect
        numOfRoomTxt.layer.cornerRadius = 5
        numOfRoomTxt.layer.borderWidth = 1
        numOfRoomTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        
        bedTxt.borderStyle = UITextBorderStyle.RoundedRect
        bedTxt.layer.cornerRadius = 5
        bedTxt.layer.borderWidth = 1
        bedTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        
        maxOccupTxt.borderStyle = UITextBorderStyle.RoundedRect
        maxOccupTxt.layer.cornerRadius = 5
        maxOccupTxt.layer.borderWidth = 1
        maxOccupTxt.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.18, alpha: 0.09).CGColor
        updateButton.layer.cornerRadius = 5
        facilityView.layer.cornerRadius = 5
        
    }

    func initNavUnderline(){
        navunderlive.frame = CGRectMake(self.view.frame.size.width/3, (self.navigationController?.navigationBar.frame.size.height)! - 3, self.view.frame.size.width/3, 3)
        navunderlive.backgroundColor = UIColor.redColor()
       self.navigationController?.navigationBar.addSubview(navunderlive)
        
    }
    override func viewDidDisappear(animated: Bool) {
        print("viewDidDisappear(Edit)")
        for i in 0...appDelegate.facilityRoomStatus.count - 1
        {
            appDelegate.facilityRoomStatus[i] = false
        }
    }
    @IBAction func addFacilityBtn(sender: AnyObject) {
        let alertView = CustomIOS7AlertView()
        alertView.containerView = createContainerView()
        alertView.delegate = self
        alertView.buttonColor = UIColor.redColor()
        alertView.show()
    }
    func customIOS7AlertViewButtonTouchUpInside(alertView: CustomIOS7AlertView, buttonIndex: Int) {
        alertView.close()
        print("customIOS7AlertViewButtonTouchUpInside")
        
        self.facilitiesRoomAttached.removeAll()
        for i in 0...appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count - 1
        {
            if (self.appDelegate.facilityRoomStatus[i] as Bool)
            {
                self.facilitiesRoomAttached.append(appDelegate.facilityRoomDic!["roomTypeFacilities"]![i]["facility_name_en"] as! String)
            }
            
        }
        tableView.reloadData()
    }
    func closealert(sender: UIButton, alertView: CustomIOS7AlertView) {
        alertView.close()
        print("closealert")
    }
    // Create a custom container view
    func createContainerView() -> UIView {
        width = UIScreen.mainScreen().bounds.size.width
        height = UIScreen.mainScreen().bounds.size.height
        let containerView = UIView(frame: CGRectMake(0, 0, 300, height - 100))
        let subView1: UIView = NSBundle.mainBundle().loadNibNamed("roomfacility", owner: self, options: nil)[0] as! UIView
        
        subView1.frame = containerView.bounds
      
        containerView.addSubview(subView1)
        
        return containerView
    }
    
    @IBAction func btnBack(sender: AnyObject) {
        print("Back")
        let nev = self.storyboard?.instantiateViewControllerWithIdentifier("navCon")
        self.navigationController?.presentViewController(nev!, animated: true, completion: { () -> Void in
            self.appDelegate.viewWithTopButtons.hidden = false
            self.navunderlive.hidden = true
        })
        appDelegate.pagecontrolIndex = 2

 // self.performSegueWithIdentifier("backtoinfo", sender: self)
}

    @IBAction func btnUpdateRoom(sender: AnyObject) {
        print("update room")
//        uploadImage()
        
        
        let send = API_Model()
        let dataDic = [
            "providerInformation" : [
                "providerId" : Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,
                "providerTypeKeyname" : "hotel"
            ],
            //Room
            "roomType":[
                "roomTypeId": (appDelegate.roomDic!["roomTypes"]![appDelegate.roomIndex!]!["room_type_id"] as! String),
                "roomTypeNameEn": roomNameTxt.text!,
                "roomTypeNameTh": "",
                "roomTypeDescriptionEn": shotDescTxt.text,
                "roomTypeDescriptionTh": numOfRoomTxt.text,
                "roomTypeAvgPrice":"",
                "roomTypeCurrentPrice": priceTxt.text,
                "quantity": "",
                "maximumPerson": maxOccupTxt.text,
                "touchbookingpaymentProductKeycode": ""
            ],
            "user" : [
                "accessToken" : appDelegate.userInfo["accessToken"]!
            ]
        ]
        
        let dataJson = send.Dict2JsonString(dataDic)
        
        print("data Send Json :\(dataJson)")
        print("Json Encode :\(send.jsonEncode(dataJson))")
        send.providerAPI(self.appDelegate.command["UpdateRoomType"]!, dataJson: dataJson){
            data in
            print("data(UpdateRoom) :\(data)")
//            print("data(roomTypeId) : \(data["roomType"]!["room_type_id"] as! Int)")
            self.setFacility(Int(self.appDelegate.roomDic!["roomTypes"]![self.appDelegate.roomIndex!]!["room_type_id"] as! String)!)
            
        }
        
        

        
        
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        //        PKHUD.sharedHUD.contentView = PKHUDStatusView(title: "Loading", subtitle: "Subtitle", image: nil)
        PKHUD.sharedHUD.show()
        
        
        print("countImage \(roomImageUpload.count) ")
        if(roomImageUpload.count != 0)
        {
            let date = NSDate();
            let dateFormatter = NSDateFormatter()
            //To prevent displaying either date or time, set the desired style to NoStyle.
            dateFormatter.dateFormat = "MM-dd-yyyy-HH-mm"
            dateFormatter.timeZone = NSTimeZone()
            let imageDate = dateFormatter.stringFromDate(date)
            
            for index in 0...self.roomImageUpload.count-1
            {
                let imageName = imageDate + "-" + String(index)+".jpg"
                print("ImageName \(imageName)")
                send.getUploadKeyRoomGallery(Int(self.appDelegate.roomDic!["roomTypes"]![self.appDelegate.roomIndex!]!["room_type_id"] as! String)!,imageName: imageName){
                    data in
                    
                    print("data getUploadKeyRoomGallery: \(data)")
                    let mediaKey = data 
                    self.send.uploadImage(mediaKey, image: self.roomImageUpload[index], imageName: imageName){
                        data in
                        if(index == self.roomImageUpload.count-1)
                        {
                            PKHUD.sharedHUD.hide(afterDelay: 0.1)
                            let alert = SCLAlertView()
                            alert.showCircularIcon = false
                            alert.showInfo("Information", subTitle: "Update Room Success", colorStyle:0xAC332F ,duration: 2.0)
                            let nev = self.storyboard!.instantiateViewControllerWithIdentifier("navCon") as! UINavigationController
                            
                            self.navigationController?.presentViewController(nev, animated: true, completion: { () -> Void in
                                
                                self.appDelegate.viewWithTopButtons.hidden = false
                                self.navunderlive.hidden = true
                                
                            })

                        }
                    }
                }
            }
        }else
        {
            PKHUD.sharedHUD.hide(afterDelay: 0.1)
            let alert = SCLAlertView()
            alert.showCircularIcon = false
            alert.showInfo("Information", subTitle: "Update Room Success", colorStyle:0xAC332F ,duration: 2.0)
            let nev = self.storyboard!.instantiateViewControllerWithIdentifier("navCon") as! UINavigationController
            
            self.navigationController?.presentViewController(nev, animated: true, completion: { () -> Void in
                
                self.appDelegate.viewWithTopButtons.hidden = false
                self.navunderlive.hidden = true
                
            })

        }


        appDelegate.pagecontrolIndex = 2

    }
    
    func getFacility()
    {
        //print("roomDataALL : \(self.appDelegate.roomDic!["roomTypes"])")  7288
        let dataDic =
        [
            "roomType": [
                "roomTypeId": self.appDelegate.roomDic!["roomTypes"]![self.appDelegate.roomIndex!]!["room_type_id"] as! String
            ]
        ]
        
        let dataJson = send.Dict2JsonString(dataDic)
        print("data Send Json :\(dataJson)")
        print("Json Get(Room)FacilityAttached :\(send.jsonEncode(dataJson))")
        //Update Provider
        send.providerAPI(self.appDelegate.command["GetRoomTypeFacilityAttached"]!, dataJson: dataJson)
            {
                data in
                print("data(Get(Room)FacilityAttached) :\(data)")
                print("Count \(data["roomTypeFacilitiesAttached"]!.count )")
                if(data["roomTypeFacilitiesAttached"]!.count != 0 )
                {
                    for i in 0...data["roomTypeFacilitiesAttached"]!.count - 1
                    {
                        print(data["roomTypeFacilitiesAttached"]![i]["facility_keyname"])
                        print("Fac Room Dic WTF : \(self.appDelegate.facilityRoomDic!)")
                        print("CountWTF : \(self.appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count)")
                        for j in 0...self.appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count - 1
                        {

                            if((data["roomTypeFacilitiesAttached"]![i]["room_type_facility_id"] as! String) == (self.appDelegate.facilityRoomDic!["roomTypeFacilities"]![j]!["room_type_facility_id"] as! String))
                            {
                                self.appDelegate.facilityRoomStatus[j] = true
                                print("index : \(j) \(data["roomTypeFacilitiesAttached"]![i]["room_type_facility_id"] as! String)")
                                print("index : \(j) \(self.appDelegate.facilityRoomDic!["roomTypeFacilities"]![j]!["room_type_facility_id"] as! String)")
                                
                            }
                            
                        }
                        self.facilitiesRoomAttached.append(data["roomTypeFacilitiesAttached"]![i]["facility_keyname"] as! String)
                    }
                }
                self.tableView.reloadData()
                print("============facilitiesRoomAttached.count\(self.facilitiesRoomAttached.count)")
                
        }
        
    }
    
    
    func updateData(){
        //   print("data All\(appDelegate.roomDic!["ListProviderInformationSummary"]![appDelegate.roomIndex!])")
        
        //        roomNameTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["roomTypeNameEn"]! as! String)
        //
        //        shotDescTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["roomTypeDescriptionEn"]! as! String)
        //
        //
        //        priceTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["roomTypeCurrentPrice"]! as! String)
        //        maxOccupTxt.text = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["maximumPerson"]! as! String)
    }
    
    func setFacility(roomTypeId:Int)
    {
        
        print("RoomID \(roomTypeId)")
        var dataDic =
        [
            "roomType" :
                [
                    "roomTypeId" : roomTypeId,
            ],
            "roomTypeFacilitiesAttached" :[],
            
            "user" : [
                "accessToken" : appDelegate.userInfo["accessToken"]!
            ]
        ]
        
        print("RoomFacility : \(appDelegate.facilityRoomDic)")
        var facilitiesAttached:[[String:String]] = []
        for i in 0...appDelegate.facilityRoomDic!["roomTypeFacilities"]!.count - 1
        {
            if (self.appDelegate.facilityRoomStatus[i] as Bool)
            {
//                "room_type_facility_id": "1",
//                "facility_keyname": "air",
//                "quantity": "0",
                facilitiesAttached.append(
                    ["room_type_facility_id": appDelegate.facilityRoomDic!["roomTypeFacilities"]![i]["room_type_facility_id"] as! String,
                    "facility_keyname": appDelegate.facilityRoomDic!["roomTypeFacilities"]![i]["facility_name_en"] as! String,
                    "quantity": "0", ])
      //              print("fac OK \(appDelegate.facilityRoomDic!["roomTypeFacilities"]![i])")
            }
        
        }
        
            dataDic["roomTypeFacilitiesAttached"] = facilitiesAttached
            let dataJson = send.Dict2JsonString(dataDic)
        
            print("data Send Json(setFac) :\(dataJson)")
            print("Json Encode :\(send.jsonEncode(dataJson))")
        //Update SetFacilityAttached
        send.providerAPI(self.appDelegate.command["SetRoomTypeFacilityAttached"]!, dataJson: dataJson){
                data in
                print("data(SetRoomFacilityAttached) :\(data)")
        
            }
    }
    func buttonTapped(btn:SCLButton) {
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    func dismissKeyboard()
    {
        roomNameTxt.resignFirstResponder()
        priceTxt.resignFirstResponder()
        numOfRoomTxt.resignFirstResponder()
        bedTxt.resignFirstResponder()
        maxOccupTxt.resignFirstResponder()
        shotDescTxt.resignFirstResponder()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    
    // MARK: UICollectionViewDataSource
    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView)->Int {
//        //#warning Incomplete method implementation -- Return the number of sections
//        return 1
//    }
    
    func imageTapped(img: AnyObject)
    {
        pickerType = "profileImage"
        
        print("Upload Cover Img")
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    func imageTapped2(img: AnyObject)
    {
        pickerType = "roomImage"
        
        print("Upload Cover Img2")
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
//        return roomGallery.count+addImageNum
        return roomGallery.count+1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/3 - 2, height: collectionView.frame.size.width/3-1)
    }
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->UICollectionViewCell {
        Cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell",forIndexPath: indexPath) as! RoomGalleryCell
        
        print("roomGallery \(roomGallery.count)")
        if(self.roomGallery.count == 0 || indexPath.row == self.roomGallery.count)
        {
            print("if")
            Cell.imgRoom.image = UIImage(named: "add_image.png")
            
        }else
        {
            Cell.imgRoom.image = self.roomGallery[indexPath.row]
            print("else")
        }
        
        print("Cell display")
        return Cell
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Did select")
        self.imageTapped(indexPath.item)
    }
 
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilitiesRoomAttached.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if(facilitiesRoomAttached.count == 0){
            cell.textLabel?.text = ""
        }
        else{
            // var facilitiesAttached:[[String:String]] = []
            cell.textLabel?.text = facilitiesRoomAttached[indexPath.row]
            print("facilitiesRoomAttached(table) \(facilitiesRoomAttached[indexPath.row])")
        }
        
        //cell.textLabel?.text = "facility name"
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Select")
        
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print("ImagePicker")
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        
    
        print("ImagePicker:roomImage")
        let date = NSDate();
        let dateFormatter = NSDateFormatter()
        //To prevent displaying either date or time, set the desired style to NoStyle.
        dateFormatter.dateFormat = "MM-dd-yyyy-HH-mm"
        dateFormatter.timeZone = NSTimeZone()
        var imageName = dateFormatter.stringFromDate(date)
        imageName = imageName + ".jpg"
        print("imageName : \(imageName)")
        
        dismissViewControllerAnimated(true, completion: nil)
        self.roomGallery.append(chosenImage)
        self.roomImageUpload.append(chosenImage)
        self.collectionView.reloadData()
    }
    func getRoomGallery()
    {
        let send = API_Model()
        
        send.getRoomGallery(appDelegate.roomDic!["roomTypes"]![appDelegate.roomIndex!]!["room_type_id"] as! String){
            data in
//            PKHUD.sharedHUD.hide(afterDelay: 1.0)
            print("data.count \(data.count)")
            print("data.ALL \(data)")
            print("roomGall \(self.roomGallery.count)")
            if(data.count > 0)
            {
                for index in 0...(data.count-1)
                {
                    
                    print("getRoomGalleryyyy \(index): \(data[index]["thumbnail"])")
                    self.roomGallery.append(UIImage(data: NSData(contentsOfURL: NSURL(string: (data[index]["thumbnail"] as! String))!)!)!)
                    
                }
                
            }

            
//            self.roomGallery = data
            print("UP แล้วจ้า")

            self.collectionView.reloadData()
        }
        
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if(self.view.isDescendantOfView(self.collectionView))
        {
            print("if gestureRecognizer")
            return false
        }
        else
        {
            print("else gestureRecognizer")
            return true
        }
    }
    
}
