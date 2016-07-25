//
//  ResLocationVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/9/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import MapKit
class ResLocationVC: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var propertyView1: UIView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var latTxt: UITextField!
    @IBOutlet weak var longTxt: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var saveLocationBtn: UIButton!
    var propertyView2 = UIView()
    var locationImageicon = UIImageView()
    var locationText = UITextView()
    var Latlbl = UILabel()
    var Longlbl = UILabel()
    
    var lat = String()
    var long = String()
    
    var changLocationBar = UIView()
    var changLocationBtn = UIButton()
    var Buttonlbl = UILabel()
    var ButtonImg = UIImageView()
    var changLocationBarH = CGFloat()
    
    var point: MyCustomPointAnnotation = MyCustomPointAnnotation()
    var annotation: MyCustomPointAnnotation = MyCustomPointAnnotation()
    var locationname = String()
    var cityname = String()
    
    
    @IBAction func saveLocationBtn(sender: AnyObject) {
        self.changeDetial()
        self.propertyView2.hidden = false
        self.changLocationBar.hidden = false
        self.saveLocationBtn.hidden = true
        //   self.propertyView1.hidden = true
        print("lat :\(latTxt.text) long: \(longTxt.text)")
        print("save Button")
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            
            let send = API_Model()
            let dataDic = [
                "providerInformation" :
                    [
                        "providerId" : Int(self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["provider_id"]! as! String)!,
                        "providerTypeKeyname" : "hotel",
                        "longitude": self.longTxt.text! as String,
                        "latitude": self.latTxt.text! as String
                ],
                "user" : [
                    "accessToken" : self.appDelegate.userInfo["accessToken"]!
                ]
            ]
            
            let dataJson = send.Dict2JsonString(dataDic)
            
            print("data Send Json :\(dataJson)")
            print("Json Encode :\(send.jsonEncode(dataJson))")
            
            //Update Provider
            send.providerAPI(self.appDelegate.command["updateProvider"]!, dataJson: dataJson){
                data in
                print("data (Location):\(data)")
                
                let dataJson = "{\"providerUser\":\"\(self.appDelegate.userInfo["email"]!)\"}"
                //print("appDelegate :\(appDelegate.userInfo["email"])")
                print("dataSendJson : \(dataJson)")
                send.providerAPI(self.appDelegate.command["listProvider"]!, dataJson: dataJson){
                    data in
                    
                    self.appDelegate.providerData = data
                    
                    let letChange = self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["latitude"]! as! String
                    let longChange = self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["longitude"]! as! String
                    
                    let senderTag = sender.tag as Int
                    print("senderTag:\(senderTag)")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        if(senderTag == 999){
                            print("latitude:\(self.appDelegate.latitude)")
                            print("longitude:\(self.appDelegate.longitude)")
                            self.Latlbl.text = self.appDelegate.latitude
                            self.Longlbl.text = self.appDelegate.longitude
                            
                            
                        }else{
                            print("LATTT ::: \(letChange)")
                            self.latTxt.text = letChange
                            print("LONGG ::: \(longChange)")
                            self.longTxt.text = longChange
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func changeDetial(){
        
        propertyView2.frame = CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height/3)
        propertyView2.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(propertyView2)
        
        locationImageicon.frame = CGRectMake(self.propertyView2.frame.size.width/2-30, self.propertyView2.frame.size.height/6, 50, 60)
        let imgPin: UIImage = UIImage(named: "icon_pin_nearme.png")!
        locationImageicon.image = imgPin
        propertyView2.addSubview(locationImageicon)
        
        locationText.frame = CGRectMake(0, self.propertyView2.frame.size.height/5 +  locationImageicon.frame.size.height, self.propertyView2.frame.size.width, 50)
        locationText.text = NSString(format: "%@ %@", self.locationname , self.cityname) as String
        locationText.textAlignment = .Center
        locationText.textColor = UIColor.grayColor()
        locationText.font = UIFont(name: "Helvetica", size: 16)
        propertyView2.addSubview(locationText)
        
        let LatlblW = propertyView2.frame.size.width/2
        
        Latlbl.frame = CGRectMake(0, self.propertyView2.frame.size.height - 45 , LatlblW , 40)
        Latlbl.text = latTxt.text
        Latlbl.font = UIFont(name: "Helvetica", size: 16)
        Latlbl.textAlignment  = .Center
        propertyView2.addSubview(Latlbl)
        
        Longlbl.frame = CGRectMake(propertyView2.frame.size.width/2, self.propertyView2.frame.size.height - 45 , LatlblW , 40)
        Longlbl.text = longTxt.text
        Longlbl.font = UIFont(name: "Helvetica", size: 16)
        Longlbl.textAlignment  = .Center
        propertyView2.addSubview(Longlbl)
        
        changLocationBarH =  self.view.frame.size.height/5
        changLocationBar.frame = CGRectMake(0,self.view.frame.size.height-changLocationBarH, self.view.frame.size.width,changLocationBarH)
        changLocationBar.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(changLocationBar)
        
        changLocationBtn.frame = CGRectMake(20, 20 ,changLocationBar.frame.size.width - 40 ,changLocationBarH - 40)
        changLocationBtn.backgroundColor = UIColor.redColor()
        changLocationBtn.layer.cornerRadius = 5
        Buttonlbl.frame = CGRectMake(0,0,changLocationBtn.frame.size.width,50)
        
        changLocationBtn.addTarget(self, action: #selector(ResLocationVC.updateLocation(_:)), forControlEvents: .TouchUpInside)
        Buttonlbl.center.y = changLocationBtn.frame.size.height/2
        Buttonlbl.textAlignment = .Center
        Buttonlbl.text = "Change Location"
        Buttonlbl.textColor = UIColor.whiteColor()
        Buttonlbl.font = UIFont(name: "Helvetica", size: 20)
        changLocationBtn.addSubview(Buttonlbl)
        changLocationBar.addSubview(changLocationBtn)
        
        let imgButton: UIImage = UIImage(named: "icon-2.png")!
        ButtonImg.image = imgButton
        ButtonImg.frame = CGRectMake(0, 0, changLocationBtn.frame.size.height, changLocationBtn.frame.size.height)
        changLocationBtn.addSubview(ButtonImg)
    }
    func updateLocation(sender : UIButton){
        self.saveLocationBtn.hidden = false
        print("true")
        self.propertyView2.hidden = true
        self.changLocationBar.hidden = true
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.latTxt.delegate = self
        self.longTxt.delegate = self
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
     
        
        let lpgr: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ResLocationVC.handleLongPress(_:)))
        lpgr.minimumPressDuration = 1.0
        //user needs to press for 1 seconds
        self.mapView.addGestureRecognizer(lpgr)
        
    }
    override func viewWillAppear(animated: Bool) {
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // stuff
        
        if let touch =  touches.first{
            print("\(touch)")
            let location = touch.locationInView(self.view)
            print(location)
        }
        super.touchesBegan(touches, withEvent: event)
        //        let touch = touches.anyObject()! as! UITouch
        //        let location = touch.locationInView(self)
        //        print(location)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        print("------- location -------")
        
        var _lat = ""
        var _lng = ""
        var _titleName = ""
        
        if let latitude = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["latitude"]!) {
            _lat = latitude as! String
        }
        
        if let longitude = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["longitude"]!) {
            _lng = longitude as! String
        }
        
        if let title = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["name_en"]!) {
            _titleName = title as! String
        }
        
        print("_lat = \(_lat)")
        print("_lng = \(_lng)")
        
        if((_lat != "" && _lng != "") && (_lat != "0" && _lng != "0")){
            
            self.propertyView2.hidden = true
            self.changLocationBar.hidden = true
            
            self.latTxt.text = NSString(format: "%.6f",Double(_lat)!) as String
            self.longTxt.text = NSString(format: "%.6f",Double(_lng)!) as String
            
            print("Location Set")
            point.coordinate = CLLocationCoordinate2DMake(Double(_lat)!,Double(_lng)! )
            point.name = _titleName
            point.title = _titleName
            //point.subtitle = "Current Subtitle"
            self.mapView.addAnnotation(point)
            self.mapView.showsUserLocation = false
            
            let Coordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(_lat)!,Double(_lng)!)
            let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(Coordinates, 1000, 1000)
            self.mapView.setRegion(viewRegion, animated:true)
        }else{
            
            self.propertyView2.hidden = false
            self.changLocationBar.hidden = false
            
            
            self.latTxt.text = _lat
            self.longTxt.text = _lng
            
            if CLLocationManager.locationServicesEnabled(){
                
                print("locationServicesEnabled true")
                
                print("appDelegate.latitude = \(appDelegate.latitude)")
                print("appDelegate.longitude = \(appDelegate.longitude)")
                
                if((appDelegate.latitude != "") && (appDelegate.longitude != "")  && (appDelegate.latitude != "0")  && (appDelegate.longitude != "0") ){
                    
                    self.latTxt.text = self.appDelegate.latitude
                    self.longTxt.text = self.appDelegate.longitude
                    
                    let btnSender = UIButton()
                    btnSender.tag = 999
                    self.saveLocationBtn(btnSender)
                    
                    self.propertyView2.hidden = true
                    self.changLocationBar.hidden = true
                    self.saveLocationBtn.hidden = false
                    
                    point.coordinate = CLLocationCoordinate2DMake(Double(appDelegate.latitude)!,Double(appDelegate.longitude)! )
                    self.mapView.addAnnotation(point)
                    
                    let Coordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(appDelegate.latitude)!,Double(appDelegate.longitude)!)
                    let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(Coordinates, 4000, 4000)
                    self.mapView.setRegion(viewRegion, animated:true)
                    
                }else{
                    
                    // ---------- ตั้งค่าแผนที่ให้เป็นประเทศไทยก่อน
                    let Coordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(13.6947008),Double(101.6475268))
                    let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(Coordinates, 1500000, 1500000)
                    self.mapView.setRegion(viewRegion, animated:true)
                }
                
            }else{
                
                print("locationServicesEnabled false")
                // ---------- ตั้งค่าแผนที่ให้เป็นประเทศไทยก่อน
                let Coordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(13.6947008),Double(101.6475268))
                let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(Coordinates, 1500000, 1500000)
                self.mapView.setRegion(viewRegion, animated:true)
            }
            
        }
        
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't do anything if it's the user's location point
        if (annotation is MKUserLocation) {
            return nil
        }
        // We could display multiple types of point annotations
        if (annotation is MyCustomPointAnnotation) {
            print("Title : \(annotation.description)")
            //            let pin: MyCustomPinAnnotationView = MyCustomPinAnnotationView(annotation: annotation)
            let pin: MyCustomPinAnnotationView = MyCustomPinAnnotationView(annotation: annotation, type: 1)
            return pin
        }
        return nil
    }
    func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state != .Began {
            return
        }
        let touchPoint: CGPoint = gestureRecognizer.locationInView(self.mapView)
        let touchMapCoordinate: CLLocationCoordinate2D = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        
        annotation.coordinate = touchMapCoordinate
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
        
        print("Coordinate \(annotation.coordinate)")
        
        latTxt.text = NSString(format: "%.8f",annotation.coordinate.latitude) as String
        longTxt.text = NSString(format: "%.8f",annotation.coordinate.longitude) as String
        
        annotation.name = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["name_en"]! as! String)
        
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary)
            print("Location Name ::::")
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? NSString  {
                print("loName:::: \(locationName)")
                self.locationname = NSString(format: "%@",locationName) as String
            }
            // Street address
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                print("streetName :::\(street)")
            }
            
            // City
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                print("City ::::\(city)")
                self.cityname = NSString(format: "%@",city) as String
                
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                print("Zipcode :::: \(zip)")
            }
            
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                print("countryName :::\(country)")
            }
            
            
        })
        
        
        
        print("Annotation Name: \(self.annotation.name)")
        self.mapView.addAnnotation(self.annotation)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        print("lacationManager")
        let location = locations.last! as CLLocation
        
        
        print("latitude : \(location.coordinate.latitude)")
        print("longitude : \(location.coordinate.longitude)")
        appDelegate.latitude = String(location.coordinate.latitude)
        appDelegate.longitude = String(location.coordinate.longitude)
        
        locationManager.stopUpdatingLocation()
        
    }
    override func viewDidDisappear(animated: Bool) {
        //mapView.removeFromSuperview()
        print("viewDidDisappear")
    }
    
    
}
