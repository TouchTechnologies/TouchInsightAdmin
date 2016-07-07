//
//  ImageGalleryVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/10/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import PagingMenuController
import Alamofire
import PKHUD
class ResImageGalleryVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var mediaKey:String!
   // let chosenImage
    var pickerPick = false
    var pickerType = ""
    var hotelImage = [UIImageView()]
    var hotelgalLbl = UILabel()
    var CoverImg = UIImageView()
    var coverImgCell = UIImageView()
    var hotelGallery = [[String:AnyObject]]()
    var defultImg = UIImage()
    var Cell = ImageCollectionViewCell()
    @IBOutlet var collectionView: UICollectionView!
    var photoGall : [String] = []
    var addImageNum = 0
    @IBOutlet var baseView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var firstV: UIView!
     var secondV = UIView()
    @IBOutlet var coverImgLbl: UILabel!
     var addimgBtn = UIButton()
    
    @IBOutlet var saveButton: UIButton!
    
    @IBAction func btnBack(sender: AnyObject) {
        let providerlistview = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
        self.navigationController?.pushViewController(providerlistview!, animated: true)
    }
    @IBAction func addImageBtn(sender: AnyObject) {
//        print("data All\(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!])")
//        print("provider ID\(Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!)")
        print("addImage")
        let send = API_Model()
//        send.getUploadKey(Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,imageName: "aaaaa"){
//            data in
//            print(data)
//            self.mediaKey = data
//        }
        print("Media Key : \(mediaKey)")
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
 
    }
 
    
    @IBAction func saveGalleryBtn(sender: AnyObject) {
        print("Upload")
        let providerlistview = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
        self.navigationController?.pushViewController(providerlistview!, animated: true)

        
//        let providerlistview = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist") as! ProviderListVC
//        self.navigationController?.pushViewController(providerlistview, animated: true)
        
    }
    func initialSize(){
    let width = UIScreen.mainScreen().bounds.size.width
    let height = UIScreen.mainScreen().bounds.size.height
    defultImg = UIImage(named: "bg_cctvdefault.png")!
        
        self.baseView.frame = CGRectMake(0, 0, width, height)
        self.scrollView.frame = CGRectMake(0, 0, width, height)
        self.scrollView.contentSize = CGSizeMake(width, height+200)
        self.firstV.frame = CGRectMake(10, 10, width - 20, height/2 - 100)
        self.firstV.backgroundColor = UIColor.clearColor()

        
        self.coverImgLbl.frame = CGRectMake(0, 0, self.firstV.frame.size.width, 30)
          self.coverImgLbl.backgroundColor = UIColor.clearColor()
       
        CoverImg.frame = CGRectMake(0,30,self.firstV.frame.size.width,self.firstV.frame.size.height - 30)
        CoverImg.contentMode = UIViewContentMode.ScaleToFill
        hotelImage[0].frame = CGRectMake(0,30,self.firstV.frame.size.width,self.firstV.frame.size.height - 30)
//        CoverImg.image = UIImage(named: "bg_cctvdefault.png")
       
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        CoverImg.userInteractionEnabled = true
        CoverImg.addGestureRecognizer(tapGestureRecognizer)
        self.firstV.addSubview(self.CoverImg)
        
        
        
        self.hotelgalLbl.frame = CGRectMake(10 , self.firstV.frame.size.height + 20 , self.firstV.frame.size.width, 30)
        self.hotelgalLbl.text = "Hotel Image"
        self.hotelgalLbl.font = UIFont(name: "Helvetica", size: 18)
        self.scrollView.addSubview(hotelgalLbl)
        
        
        self.collectionView.frame = CGRectMake(10 , self.hotelgalLbl.frame.origin.y + 50 , self.firstV.bounds.size.width, self.firstV.bounds.size.width)
       
        self.saveButton.frame.origin.y = self.collectionView.frame.origin.y + self.collectionView.frame.size.height + 20
        self.saveButton.frame.size.width = self.collectionView.frame.size.width
        self.saveButton.center.x = width/2
        
        
//        self.imgcell.frame = CGRectMake(0 , 0, self.collectionView.frame.size.width/3 - 4, self.collectionView.frame.size.width/3 - 4)
//        self.imgcell.backgroundColor = UIColor.blueColor()
//        
        
        self.scrollView.addSubview(self.collectionView)
        
    
    }
    func imageTapped(img: AnyObject)
    {
    
        print("Upload Cover Img Tag : \(img.tag)")
        pickerType = "coverImage"
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    func imageTapped2(img: AnyObject)
    {
        pickerType = "hotelImage"
        
        print("Upload Cover Img2")
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView)->Int {
//        //#warning Incomplete method implementation -- Return the number of sections
//        return 6
//    }
//
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        print("hotelGallery.count \(hotelGallery.count)")
        return hotelGallery.count+1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width/3 - 2, height: collectionView.frame.size.width/3-2)
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->UICollectionViewCell {
        
      Cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell",forIndexPath: indexPath) as! ImageCollectionViewCell
    return Cell
        
}
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
       // Cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell",forIndexPath: indexPath) as! ImageCollectionViewCell
        
        
        
        if (self.hotelGallery.count == 0 || indexPath.row == self.hotelGallery.count)
            
        {
            Cell.imageColl.image = UIImage(named: "add_image.png")
        }else
        {
            
            print("imageGal \(self.hotelGallery[indexPath.row]["thumbnail"])")
            //            Cell.imageColl.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://192.168.9.58/framework/public/resource/insight/hotel/1965/gallery/image/asset-small.jpg")!)!)
            
            
            let strURL = (self.hotelGallery[indexPath.row]["thumbnail"]) as! String
            if strURL == "http://192.168.9.58/framework/public/resource/insight/hotel/default/gallery/thumbnail/default.png" {
                print("ERROR")
                Cell.imageColl.removeFromSuperview()
                let lblError = UILabel()
                lblError.frame = CGRectMake(0, Cell.frame.size.height/2 - 15, Cell.frame.size.width, 30)
                lblError.text = "loading..."
                lblError.textAlignment = .Center
                Cell.addSubview(lblError)
                
                
            }
            else{
                print("\(indexPath.row ) = strURL ::\(strURL)")
                
                Cell.imageColl.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strURL )!)!)
            }
            
        }


            
    }
//func verifyUrl (urlString: String?) -> Bool {
//    print("VERIFY URL")
//        //Check for nil
//        if let urlString = urlString {
//            // create NSURL instance
//              let strURL = "http://192.168.9.58/framework/public/resource/insight/hotel/default/gallery/thumbnail/default.png"  as! String
//            if let url = NSURL(string: strURL) {
//                // check if your application can open the NSURL instance
//                return UIApplication.sharedApplication().canOpenURL(url)
//            }
//        }
//        return false
//    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("collectionView didSelectItemAtIndexPath")
     self.imageTapped2(indexPath.item)
    
    }
    
    func uploadcoverImg(){
     }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSize()
        self.getGallery()
        
        // Do any additional setup after loading the view.
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        CoverImg.image = image
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }

    override func viewWillAppear(animated: Bool) {
       self.initialSize()
        print("viewWillAppear(imggall)")
        print("cover_image1 \(self.appDelegate.providerIDData!["GetProviderInformationById"]!["cover_image"])")
//        let urlImage = self.appDelegate.providerIDData!["GetProviderInformationById"]!["cover_image"] as! String
//        print("URL IMAGE :::\(urlImage)")
//        if(urlImage == "http://192.168.9.58/framework/public/resource/insight/hotel/default/cover/default.png"){
//          CoverImg.image = UIImage(named: "bg_cctvdefault.png")
//        }
//        else{
//        
//          CoverImg.image =  UIImage(data: NSData(contentsOfURL: NSURL(string:urlImage)!)!)
//        
//        }
       
        
        if let coverImg = self.appDelegate.providerIDData!["GetProviderInformationById"]!["cover_image"] {
        print("Has Cover img")
//        if(coverImg as! String == "http://192.168.9.58/framework/public/resource/insight/hotel/default/cover/default.png"){
            if(coverImg as! String == "http://insight.touch-ics.com/_develop/public/resource/insight/hotel/default/cover/default.png"){
            
            print("URL Defult")
                      CoverImg.image = UIImage(named: "bg_cctvdefault.png")
                    }
                    else{
              print("URL not Defult")
                      CoverImg.image =  UIImage(data: NSData(contentsOfURL: NSURL(string:coverImg as! String)!)!)
                    
                    }
        
        }
        else{
          print("No Cover img")
            CoverImg.image = UIImage(named: "bg_cctvdefault.png")
        }

        
    
        //      CoverImg.image =  UIImage(data: NSData(contentsOfURL: NSURL(string:self.appDelegate.providerIDData!["GetProviderInformationById"]!["cover_image"] as! String)!)!)
    //        Cell.imgProvider.image = (appDelegate.providerData!["ListProviderInformationSummary"]![indexPath.row]![cover_image]! as! String)
//        
//        if (pickerPick == false) {
//            CoverImg.image = UIImage(data: NSData(contentsOfURL: NSURL(string:self.appDelegate.providerIDData!["GetProviderInformationById"]!["cover_image"] as! String)!)!)
//        }else{
//             CoverImg.image = UIImage(named: "bg_cctvdefault.png")
//        }

//        if(self.appDelegate.providerIDData! == "http://192.168.9.58/framework/public/resource/insight/hotel/default/cover/default.png"){
//         CoverImg.image = defultImg
//        
//        }
//         CoverImg.image = defultImg
//************ BUG ****************//
//        if(pickerPick == false){
//          CoverImg.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.appDelegate.providerIDData!["GetProviderInformationById"]!["cover_image"] as! String)!)!)
//       }
        
    //   CoverImg.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.appDelegate.providerIDData!["GetProviderInformationById"]!["cover_image"] as! String)!)!)
      //  CoverImg.reloadInputViews()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //set navigation bar 
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if(pickerType == "coverImage")
        {
            print("ImagePicker:coverImage")
            let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            pickerPick = true
            
//            CoverImg.contentMode = .ScaleToFill //3
//            CoverImg.image = chosenImage //4
//            CoverImg.reloadInputViews()
            let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            let imageName = imageURL.pathComponents![1];
            print("imageName : \(imageName)")
            
            let send = API_Model()
            PKHUD.sharedHUD.dimsBackground = false
            PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
            
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()

            
            send.getUploadKey(Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,imageType: "coverImage",imageName: imageName){
                data in
                //print(data)
                self.mediaKey = data
                send.uploadImage(self.mediaKey, image: chosenImage, imageName: imageName){
                    data in
                    PKHUD.sharedHUD.contentView = PKHUDProgressView()
                    PKHUD.sharedHUD.hide(afterDelay: 1.0)
                    
                    self.dismissViewControllerAnimated(true, completion:
                    {
                        self.CoverImg.contentMode = .ScaleToFill //3
                        self.CoverImg.image = chosenImage //4
                        self.CoverImg.reloadInputViews()
//                        self.view.reloadInputViews()
                    })
                }

               // print("RESULT:::::\(results)")

                

               // self.firstV.reloadInputViews()
               
            }
//            self.firstV.addSubview(CoverImg)

            
        }
        else if(pickerType == "hotelImage")
        {
            
            print("ImagePicker:hotelImage")
            let date = NSDate();
            let dateFormatter = NSDateFormatter()
            //To prevent displaying either date or time, set the desired style to NoStyle.
            dateFormatter.dateFormat = "MM-dd-yyyy-HH-mm"
            dateFormatter.timeZone = NSTimeZone()
            var imageName = dateFormatter.stringFromDate(date)
//            print("Date Time : \(localDate)")
            
            let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            print("(hotelImage before) : \(hotelImage.count)")
            hotelImage[hotelImage.count-1].contentMode = .ScaleAspectFit
            hotelImage[hotelImage.count-1].image = chosenImage //4
//            CoverImg.contentMode = .ScaleAspectFit //3
//            CoverImg.image = chosenImage //4
            let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
//            let imageName = imageURL.pathComponents![1];
            print("(hotelImage) : \(hotelImage)")
            let send = API_Model()
            imageName = imageName + ".jpg"
            print("imageName : \(imageName)")
            
            PKHUD.sharedHUD.dimsBackground = false
            PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
            
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
            send.getUploadKeyGallery(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String, imageName: imageName){

                
                data in
                print("data getUploadKeyGallery: \(data)")
                self.mediaKey = data
                print("MEDIAKEY ::: \(self.mediaKey)")
                send.uploadImage(self.mediaKey, image: chosenImage, imageName: imageName)
                {
                    data in
                    PKHUD.sharedHUD.contentView = PKHUDProgressView()
                    PKHUD.sharedHUD.hide(afterDelay: 4.0)
                    
                    self.hotelImage[self.hotelImage.count-1].contentMode = .ScaleAspectFit
                    
                    self.hotelImage[self.hotelImage.count-1].image = chosenImage
                    //   self.hotelImage[self.hotelImage.count-1].reloadInputViews()
//                    self.Cell.imageColl.image = chosenImage
//                    self.Cell.imageColl.reloadInputViews()
                    
                    self.hotelImage[self.hotelImage.count-1].reloadInputViews()
                    self.dismissViewControllerAnimated(true, completion:
                    {
                        self.Cell.imageColl.image = chosenImage
                        self.Cell.imageColl.reloadInputViews()
                    })
                    
                    self.hotelGallery.count ==  self.hotelImage.count+1
                    self.addImageNum += 1
//                    self.collectionView.reloadData()
                }
                

         
              
            }
            

         
        }
  
    }
    func getGallery()
    {
        let send = API_Model()
        send.getGallery(Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!){
            data in
            print(": \(data)")
            self.hotelGallery = data
            self.collectionView.reloadData()
        }

    }
    

}
