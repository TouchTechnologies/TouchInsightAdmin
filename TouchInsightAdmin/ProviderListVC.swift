//
//  ProviderListVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 11/30/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//


import UIKit
import PKHUD

class ProviderListVC:UIViewController, UIScrollViewDelegate, UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, CustomIOS7AlertViewDelegate {
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var providerstype :[String] = ["HOTEL","HOTEL","HOTEL"]
    var providerType :String?
    var img : [String] = ["21.jpg","21.jpg","21.jpg"]
    var providersname : [String] = ["AAAAAAAAAAA HOTEL","BBBBBBBB HOTEL","CCCCCCCCCCC HOTEL"]
    let kInfoTitle = "Create New Provider"
    let kSubtitle:String = ("Add Your Provider Name")
    //let imggg = UIImage(named: "Left-32.png")!
    var providerTypeKeyname:String?
    var bgColor = UIColor()
    
    var closeBtn = UIButton()
    var popupView = UIView()
    var subView1 = alertCreateProviderV()
    
    var navunderlive = UIView()
    var Cell = customProviderView()

    
    @IBOutlet weak var btnCreateNew: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func btnLeft(sender: AnyObject) {
//        let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
//        self.navigationController?.pushViewController(mainView!, animated: true)
        
        self.navigationController?.popViewControllerAnimated(true)
        print("back click")
    }
    
    func initNavUnderline(){
        navunderlive.frame = CGRectMake(self.view.frame.size.width/3, (self.navigationController?.navigationBar.frame.size.height)! - 3, self.view.frame.size.width/3, 3)
        navunderlive.backgroundColor = UIColor.redColor()
        
        self.navigationController?.navigationBar.addSubview(navunderlive)
    }
    
    internal func initialAlert(){
        
    }
    
    let alert = CustomIOS7AlertView()
    @IBAction  func btnCreateProvider(sender: AnyObject) {
        print("alert ")
        
        alert.delegate = self
        alert.buttonColor = UIColor.redColor()
        alert.containerView = createpopupView()
        alert.show()
        
        
        //      alert.keyboardWillShow(NSNotification)
    }
    
    //CustomIOS7AlertViewDelegate = self
    
    /*  let send = API_Model()
     let alert = SCLAlertView()
     let txtProviderName = alert.addTextField("Provider name")
     alert.addButton("Hotel", target:self, selector:Selector("setHotel"))
     alert.addButton("Restaurant", target:self, selector:Selector("setRestaurant"))
     alert.addButton("Attraction", target:self, selector:Selector("setAttraction"))
     alert.addButton("Create"){
     print(txtProviderName.text)
     
     if self.providerTypeKeyname != nil
     {
     print("Not Null")
     let dataJson = [
     "providerInformation" : [
     "providerTypeKeyname" : self.providerTypeKeyname!,
     "nameEn"              : txtProviderName.text!,
     "nameTh"              : ""
     ],
     "user" : [
     "accessToken" : self.appDelegate.userInfo["accessToken"]!
     ]
     ]
     
     //create Provider
     send.providerAPI(self.appDelegate.command["createProvider"]!, dataJson: send.Dict2JsonString(dataJson)){
     data in
     //                    print("data :\(data)")
     
     let dataJsonUpdate = "{\"providerUser\":\"\(self.appDelegate.userInfo["email"]!)\"}"
     //print("appDelegate :\(appDelegate.userInfo["email"])")
     //                    print("dataSendJson : \(dataJsonUpdate)")
     send.providerAPI(self.appDelegate.command["listProvider"]!, dataJson: dataJsonUpdate){
     data in
     
     //                        print("listProvider :\(data["ListProviderInformationSummary"]!)")
     self.appDelegate.providerData = data
     print("Count: \(self.appDelegate.providerData!["ListProviderInformationSummary"]!.count)")
     let providerlist = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
     self.navigationController?.pushViewController(providerlist!, animated: true)
     
     }
     
     }
     
     }else
     {
     print("nil")
     }
     
     
     
     }
     
     //        alert.showEdit(kInfoTitle, subTitle:kSubtitle ,colorStyle:0xDB3F42 , colorTextButton: 0xFFFFFF )
     alert.showEdit(kInfoTitle, subTitle: kSubtitle, closeButtonTitle:"cancel", colorStyle: 0xDB3F42, colorTextButton: 0xFFFFFF)
     //         alert.showSuccess(kInfoTitle, subTitle: kSubtitle)
     */
    
    
    //    }
    internal func customIOS7AlertViewButtonTouchUpInside(alertView: CustomIOS7AlertView, buttonIndex: Int) {
        print("reload xxxx")
        
        alert.close()
        self.reloadData()
        //            tableView.reloadData()
        
        
    }
    
    //    func closealert(sender : UIButton){
    //     print("Close")
    //       //  alert.close()
    //         tableView.reloadData()
    //    }
    
    // Create a custom container view
    func createpopupView() -> UIView {
        
        popupView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width - 50, UIScreen.mainScreen().bounds.size.height - 100))
        popupView.backgroundColor = UIColor.blackColor()
        subView1 = NSBundle.mainBundle().loadNibNamed("customCreateProvider", owner: self, options: nil)[0] as! alertCreateProviderV
        subView1.createButton.addTarget(self, action: #selector(ProviderListVC.alertDismiss(_:)), forControlEvents: .TouchUpInside)
        subView1.createButton.layer.cornerRadius = 5
        subView1.frame = popupView.bounds
        subView1.providerNameTxt.layer.borderColor = UIColor.grayColor().CGColor
        subView1.providerNameTxt.layer.borderWidth = 1
        subView1.providerNameTxt.layer.cornerRadius = 5
        subView1.providerNameTxt.delegate = self
        
        popupView.addSubview(subView1)
        return popupView
    }
    func alertDismiss(sender :UIButton){
        //        alert.close()
        print("helllllll")
        //        alert.hidden = true
        //        alert.removeFromSuperview()
        //        popupView.removeFromSuperview()
        //        self.dismissViewControllerAnimated(true, completion: {})
        //        tableView.hidden = false
        //        PKHUD.sharedHUD.dimsBackground = false
        //        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        //        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        //        PKHUD.sharedHUD.show()
        //        PKHUD.sharedHUD.hide(afterDelay: 1.0)
        //        if (appDelegate.providerData!["ListProviderInformationSummary"]!.count != 0)
        //        {
        //
        //           let nib = UINib(nibName: "customProviderListVC", bundle: nil)
        //           self.tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        //            tableView.reloadData()
        //            PKHUD.sharedHUD.contentView = PKHUDSuccessView()
        //            PKHUD.sharedHUD.hide(afterDelay: 1.0)
        //
        //
        //        }
        
        tableView.reloadData()
        
    }
    func setAttraction(){
        print("Attraction")
        providerTypeKeyname = "attraction"
    }
    func setRestaurant(){
        print("Restaurant")
        providerTypeKeyname = "restaurant"
        
    }
    func setHotel(){
        print("Hotel")
        providerTypeKeyname = "hotel"
    }
    
    
    
    // @IBOutlet var providerView:UIView!
    
    /*   var txtProviderName = UITextField()
     var providerItem = String()
     var icon1 = UIImage()
     @IBAction func btnAddProvider(sender: AnyObject) {
     let alert = SCLAlertView()
     
     txtProviderName = alert.addTextField("Provider name")
     alert.addButton("Attraction",action:{
     self.providerItem = "Attraction"
     print("provider type :\(self.providerItem)")
     })
     
     alert.addButton("Restaurant",action:{
     self.providerItem = "Restaurant"
     print("provider type :\(self.providerItem)")
     
     })
     
     alert.addButton("Hotel",action:{
     self.providerItem = "Hotel"
     print("provider type :\(self.providerItem)")
     
     })
     alert.addButton("Create", target:self, selector:Selector("createProvder"))
     alert.showEdit("Create new provider", subTitle:"Add your provider name ",colorStyle : 0x50AB3C)
     
     
     }
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.providersname.count
        
        var countData = 0
        if let dicProviderData = self.appDelegate.providerData as NSDictionary? {
            
            if let arrProviderData = dicProviderData["ListProviderInformationSummary"] as! NSArray? {
                
                if let _count = arrProviderData.count as Int? {
                    countData = _count
                }
                
            }
            
        }
        return countData
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(" Index Path : \(indexPath.row)")
        
     
        if let keyType = appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]!["provider_type_keyname"]! as! String? {
            
            
//            PKHUD.sharedHUD.dimsBackground = false
//            PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
//            //PKHUD.sharedHUD.contentView = PKHUDProgressView()
//            PKHUD.sharedHUD.show()
            
            print("keyType")
            print(keyType)
            
            appDelegate.providerIndex = indexPath.row
            appDelegate.pagecontrolIndex = 0
            
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            var targetVC = UIViewController()
            if(keyType == "restaurant"){
                targetVC = storyBoard.instantiateViewControllerWithIdentifier("RestuarantListVC") as! RestuarantListVC
            }else if(keyType == "hotel"){
                targetVC = storyBoard.instantiateViewControllerWithIdentifier("ProviderInfoVC") as! ProviderInfoVC
            }else if(keyType == "attraction"){
                targetVC = storyBoard.instantiateViewControllerWithIdentifier("AttnListVC") as! AttnListVC ////////////  FAKE!!!!!!
            }
            
            self.navigationController?.pushViewController(targetVC, animated: true)
            
        }
        
        
        
        
        
//        self.performSegueWithIdentifier("showproviderinfo", sender: indexPath)
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Cell = tableView.dequeueReusableCellWithIdentifier("cell") as! customProviderView
        Cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! customProviderView
        Cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        var frmBlockView = CGRect()
        frmBlockView.size.width = self.view.frame.size.width - 10
        frmBlockView.size.height = Cell.frame.size.height - 10
        frmBlockView.origin.x = 5
        frmBlockView.origin.y = 5
        Cell.teamDetailView.frame = frmBlockView
        
        
        var frmViewIn = frmBlockView
        frmViewIn.size.width = frmBlockView.size.width - 10
        frmViewIn.size.height = frmBlockView.size.height - 10
        frmViewIn.origin.x = 5
        frmViewIn.origin.y = 5
        
        let titleHeight:CGFloat = 36
        Cell.imgProvider.frame = frmViewIn
        Cell.lblProviderName.frame.size.width = frmViewIn.size.width
        Cell.lblProviderName.frame.size.height = titleHeight
        Cell.lblProviderName.frame.origin.y = 0
        
        Cell.bgProviderName.frame.size.width = frmViewIn.size.width
        Cell.bgProviderName.frame.size.height = titleHeight
        Cell.bgProviderName.frame.origin.y = frmBlockView.size.height - (titleHeight + 5)
        
        
        print("Cell.frame")
        print(Cell.frame)
        print("----------")
        
//        print("- - - - - - - - ")
//        print(appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]!["images"]!!["cover_image"]!!["medium"])
//        print("- - - - - - - - ")
        
        // *************************** FIX BUG *************************
//        if let coverImage = appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]!["images"]!!["cover_image"]!!["medium"] as! String? {
//            
//            Cell.imgProvider.hnk_setImageFromURL(NSURL(string: coverImage)!, placeholder: UIImage(named: "ic_no_image.png"), format: nil, failure: {_ in}, success: {_ in})
//            //if let imgData = NSData(contentsOfURL:NSURL(string:logo_url)!) as NSData? {
//            //    Cell.imageColl.image = UIImage(data:imgData)
//            //}else{
//            //    Cell.imageColl.image = UIImage()
//            //}
//        }else{
//            Cell.imgProvider.image = UIImage()
//        }
        
        
        if let _cover = appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]!["images"] as! NSDictionary? {
            
            if (_cover["cover_image"]) != nil {
                
                //print("cover_image 1111")
                
                if let dicCover = _cover["cover_image"]{
                    
                    //print("cover_image 22222")
                    
                    if (dicCover["medium"]) != nil {
                        
                        //print("cover_image 33333")
                        
                        print("- - - - - - - - ")
                        print(dicCover["medium"]!)
                        print("- - - - - - - - ")
                        
                        if let coverImage = dicCover["medium"] as! String?{
                            print("CoverImage \(coverImage)")
//                            if coverImage.rangeOfString("cover/default.png") != nil {
//                                let urlLogo = NSURL(string: coverImage)
//                                self.Cell.imgProvider.hnk_setImageFromURL(urlLogo!)
//                            }else{
//                                print("Image::: \(appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]!["images"]!!)")
//                                self.Cell.imgProvider.hnk_setImageFromURL(NSURL(string:(appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]!["images"]!!["cover_image"]!!["huge"] as! String?)!)!)
//                            }
                            
                            let urlLogo = NSURL(string: coverImage)
                            self.Cell.imgProvider.hnk_setImageFromURL(urlLogo!)
                            
                        }else{
                            
                            self.Cell.imgProvider.image = UIImage(named: "ic_no_image.png")
                        }
                        
                        
                    }else{
                        print("ELSE IMAGE")
                        
                        self.Cell.imgProvider.image = UIImage(named: "ic_no_image.png")
                    }
                    
                    print("= = = = = = = = = = = = =")
                }
                
            }
            
            
//            if let dicCover = _cover["cover_image"] as! NSDictionary? {
//                
//                print("- - - - - - - - ")
//                print(dicCover)
//                print("- - - - - - - - ")
//                
////                if let coverImage = dicCover["medium"] as! String?{
////                    print("CoverImage \(coverImage)")
////                    if coverImage.rangeOfString("cover/default.png") != nil {
////                        let urlLogo = NSURL(string: coverImage)
////                        self.Cell.imgProvider.hnk_setImageFromURL(urlLogo!)
////                    }else{
////                        print("Image::: \(appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]!["images"]!!)")
////                        self.Cell.imgProvider.hnk_setImageFromURL(NSURL(string:(appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]!["images"]!!["cover_image"]!!["huge"] as! String?)!)!)
////                    }
////                    
////                }else{
////                    self.Cell.imgProvider.hnk_setImageFromURL(NSURL(string:(appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]!["cover_image"] as! String?)!)!)
////                }
//                
//            }
            
        }
    
        Cell.lblProviderType.text = (appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]!["provider_type_keyname"]! as! String)
        Cell.lblProviderName.text = (appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]!["name_en"]! as! String)
        
        return Cell
    }
    
    func reloadData() {
        
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        appDelegate.getlistProvider{data in
            
            //        PKHUD.sharedHUD.hide(afterDelay: 1.0)
            if (data["ListProviderInformationSummary"]!.count != 0){
                let nib = UINib(nibName: "customProviderListVC", bundle: nil)
                self.tableView.registerNib(nib, forCellReuseIdentifier: "cell")
                //                print("====================Provider Data==============================")
                //                print(data["ListProviderInformationSummary"]![0]!["province_id"]!)
                //                print("====================Provider Data==============================")
                self.tableView.reloadData()
                //                PKHUD.sharedHUD.contentView = PKHUDSuccessView()
                
                PKHUD.sharedHUD.hide(animated: false, completion: nil)
                
            }else{
                self.tableView.hidden = true
                //                PKHUD.sharedHUD.contentView = PKHUDSuccessView()
                PKHUD.sharedHUD.hide(animated: false, completion: nil)
            }
        }
    }
    
    var oldScrollY:CGFloat = 0
    var oldScrollAction = "down"
    var animateSuccess = true
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollY = self.tableView.contentOffset.y
        
        var currentScrollAction = "down"
        if(scrollY > oldScrollY){
            currentScrollAction = "up"
        }else{
            currentScrollAction = "down"
        }
        
        //print("scrollY = \(scrollY)")
        
        if(animateSuccess && oldScrollAction != currentScrollAction){
            //print("scrollY = \(scrollY)")
            animateSuccess = false
            if(scrollY > oldScrollY){
                //            print("UP")
                self.btnAddHiddenAction(true)
//                UIView.animateWithDuration(0.2, animations:{
//                    self.btnCreateNew.alpha = 0
//                    }, completion: {_ in
//                        self.animateSuccess = true
//                        self.oldScrollAction = "up"
//                })
            } else {
                //            print("DOWN")
                self.btnAddHiddenAction(false)
//                UIView.animateWithDuration(0.2, animations:{
//                    self.btnCreateNew.alpha = 1
//                    }, completion: {_ in
//                        self.animateSuccess = true
//                        self.oldScrollAction = "down"
//                })
            }
        }
        
        if(scrollY == 0){
            UIView.animateWithDuration(0.2, animations:{
                self.btnCreateNew.alpha = 1
                }, completion: {_ in
                    self.animateSuccess = true
                    self.oldScrollAction = "down"
            })
        }

        
        oldScrollY = scrollY
    }
    
    func btnAddHiddenAction(hidden:Bool) {
        if(hidden == true){
            UIView.animateWithDuration(0.2, animations:{
                self.btnCreateNew.alpha = 0
                }, completion: {_ in
                    self.animateSuccess = true
                    self.oldScrollAction = "up"
            })
            
        }else{
            //print("DOWN")
            UIView.animateWithDuration(0.2, animations:{
                self.btnCreateNew.alpha = 1
                }, completion: {_ in
                    self.animateSuccess = true
                    self.oldScrollAction = "down"
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init Loader
        
        self.tableView.delegate = self
        
        self.initNavUnderline()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
        
        
        let nib = UINib(nibName: "customProviderListVC", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        self.reloadData()
        
        //create alert
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisappear")
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        //tableView.reloadData()
        self.appDelegate.viewWithTopButtons.hidden = true
        //self.initialAlert()
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        print("viewDidDisappear")
        //PKHUD.sharedHUD.hide(animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProviderListVC.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProviderListVC.keyboardDidHide(_:)), name: UIKeyboardDidHideNotification, object: nil)
        self.view!.endEditing(true)
        return true
    }
    func keyboardDidShow(notification: NSNotification) {
        
        //        alert.frame = popupView.bounds    }, completion: nil)
        // Assign new frame to your view
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let height: CGFloat = UIScreen.mainScreen().bounds.size.height
        var keyboardInfo: [NSObject : AnyObject] = notification.userInfo!
        let keyboardFrameBegin: NSValue = keyboardInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrameBeginRect: CGRect =
            keyboardFrameBegin.CGRectValue()
        self.view!.frame = CGRectMake(0,-keyboardFrameBeginRect.size.height, width, height)
        //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
        
    }
    
    func keyboardDidHide(notification: NSNotification) {
        
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let height: CGFloat = UIScreen.mainScreen().bounds.size.height
        self.view!.frame = CGRectMake(0, 0, width, height)
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        
//        if segue.identifier == "showproviderinfo"{
//            appDelegate.providerIndex = sender!.row
//            appDelegate.pagecontrolIndex = 0
//            print("appIndex :\(appDelegate.providerIndex! as Int)")
//        }
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    
    
}
