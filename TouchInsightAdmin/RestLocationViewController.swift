//
//  RestLocationViewController.swift
//  TouchInsightAdmin
//
//  Created by Touch Developer on 2/23/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit

class RestLocationViewController: UIViewController ,MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var propertyView1: UIView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var latTxt: UITextField!
    @IBOutlet weak var longTxt: UITextField!
    @IBOutlet weak var mapView: MKMapView!
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
//        self.changeDetial()
//        self.propertyView2.hidden = false
//        self.changLocationBar.hidden = false
//        //   self.propertyView1.hidden = true
//        print("lat :\(latTxt.text) long: \(longTxt.text)")
//        print("save Button")
//        
//        let send = API_Model()
//        let dataDic = [
//            "providerInformation" :
//                [
//                    "providerId" : Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["provider_id"]! as! String)!,
//                    "providerTypeKeyname" : "hotel",
//                    "longitude": self.longTxt.text! as String,
//                    "latitude": self.latTxt.text! as String
//            ],
//            "user" : [
//                "accessToken" : appDelegate.userInfo["accessToken"]!
//            ]
//        ]
//        
//        let dataJson = send.Dict2JsonString(dataDic)
//        
//        print("data Send Json :\(dataJson)")
//        print("Json Encode :\(send.jsonEncode(dataJson))")
//        
//        //Update Provider
//        send.providerAPI(self.appDelegate.command["updateProvider"]!, dataJson: dataJson){
//            data in
//            print("data (Location):\(data)")
//            
//            let dataJson = "{\"providerUser\":\"\(self.appDelegate.userInfo["email"]!)\"}"
//            //print("appDelegate :\(appDelegate.userInfo["email"])")
//            print("dataSendJson : \(dataJson)")
//            send.providerAPI(self.appDelegate.command["listProvider"]!, dataJson: dataJson){
//                data in
//                
//                print("listProvider :\(data["ListProviderInformationSummary"]!)")
//                
//                
//                self.appDelegate.providerData = data
//                
//                
//                let letChange = self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["latitude"]! as! String
//                let longChange = self.appDelegate.providerData!["ListProviderInformationSummary"]![self.appDelegate.providerIndex!]["longitude"]! as! String
//                print("LATTT ::: \(letChange)")
//                self.latTxt.text = letChange
//                print("LONGG ::: \(longChange)")
//                self.longTxt.text = longChange
//                
//                
//                
//                //                let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("providerlist")
//                //                self.navigationController?.pushViewController(secondViewController!, animated: true)
//            }
//            
//        }
//        
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
        
        changLocationBtn.addTarget(self, action: "updateLocation:", forControlEvents: .TouchUpInside)
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
        
        self.latTxt.text = NSString(format: "%.6f",Double(self.appDelegate.latitude)!) as String
        self.longTxt.text = NSString(format: "%.6f",Double(self.appDelegate.longitude)!) as String
        
        
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.delegate = self
            //            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
            print("OK Location")
        }
        else{
            print("Location service disabled");
        }
        print("location")
//        if let latitude = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["latitude"]!) {
//            print("latitude  \(latitude)")
//            //latTxt.text = (latitude as! String)
//            
//            
//            //            print("Location(set) : \(Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["latitude"]! as! String))")
//            if(Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["latitude"]! as! String) != 0 )
//            {
//                print("Location Set")
//                point.coordinate = CLLocationCoordinate2DMake(Double(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["latitude"]! as! String)!,Double(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["longitude"]! as! String)! )
//                point.name = "Current Name"
//                point.title = "Current Title"
//                point.subtitle = "Current Subtitle"
//                self.mapView.addAnnotation(point)
//                
//                
//            }else
//            {
//                print("No Location Set")
//                
//                
//            }
        
//            
//        }else{
//            print("No DistanceAirport")
//            latTxt.text = ""
//        }
//        if let longitude = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["longitude"]!) {
//            print("longitude  \(longitude)")
//            longTxt.text = (longitude as! String)
//        }else{
//            print("No DistanceAirport")
//            longTxt.text = ""
//        }
//        
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        
        print("viewWillAppear(Location)")
        self.latTxt.text = NSString(format: "%.6f",Double(self.appDelegate.latitude)!) as String
        self.longTxt.text = NSString(format: "%.6f",Double(self.appDelegate.longitude)!) as String
        
        
//        
//        if let latitude = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["latitude"]!) {
//            //            print("latitude ::: \(latitude)")
//            
//            latTxt.text = (latitude as! String)
            // let point: MyCustomPointAnnotation = MyCustomPointAnnotation()
            
            
            //            print("Location(set) : \(Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["latitude"]! as! String))")
            
            
//            if(Int(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["latitude"]! as! String) != 0 )
//            {
//                print("Location Set")
//                point.coordinate = CLLocationCoordinate2DMake(Double(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["latitude"]! as! String)!,Double(appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["longitude"]! as! String)! )
//                point.name = "Current Name"
//                point.title = "Current Title"
//                point.subtitle = "Current Subtitle"
//                
//                self.mapView.addAnnotation(point)
//            }else
//            {
//                print("No Location Set")
//            }
            
//            
//        }else{
//            print("No DistanceAirport")
//            latTxt.text = ""
//        }
//        if let longitude = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["longitude"]!) {
//            //            print("longitude  \(longitude)")
//            longTxt.text = (longitude as! String)
//        }else{
//            print("No DistanceAirport")
//            longTxt.text = ""
//        }
        
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
        self.latTxt.delegate = self
        self.longTxt.delegate = self
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        print("viewDidAppear(Location)")
        
        let pointLat = NSString(format: "%.6f",Double(point.coordinate.latitude)) as String
        let pointLong =  NSString(format: "%.6f",Double(point.coordinate.longitude)) as String
        print("pointLat : \(pointLat)")
        print("lat1 : \(Double(self.appDelegate.latitude)!) long1 \(Double(self.appDelegate.longitude )!)")
        
        
        if(Int(appDelegate.latitude) != 0 )
        {
            //Set Center Location
            print("set Center Location")
            let Coordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(self.appDelegate.latitude)!,Double(self.appDelegate.longitude)! )
            print("LATITUDEEE\(Double(self.appDelegate.latitude)!)")
            //        let viewRegion = MKCoordinateRegion(center: Coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(Coordinates, 2000, 2000)
            self.mapView.setRegion(viewRegion, animated:true)
            
            self.latTxt.text = NSString(format: "%.6f",Double(self.appDelegate.latitude)!) as String
            self.longTxt.text = NSString(format: "%.6f",Double(self.appDelegate.longitude)!) as String
            
            self.propertyView2.hidden = true
            self.changLocationBar.hidden = true
            
            if(pointLat != "0.000000"){
                
                
                let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(point.coordinate, 2000, 2000)
                self.mapView.setRegion(viewRegion, animated:true)
                print("pointLat : \(pointLat)")
                self.latTxt.text = pointLat
                self.longTxt.text = pointLong
                self.changeDetial()
                self.propertyView2.hidden = false
                self.changLocationBar.hidden = false
                
            }
            
        }
        
        
        
        
        
        print("latChange111:\(self.latTxt.text))")
        
        print("latChange111:\(self.longTxt.text)")
        
        // self.latTxt.text = NSString(format: "%.6f",Double(self.appDelegate.latitude)!) as String
        //      self.longTxt.text = NSString(format: "%.6f",Double(self.appDelegate.longitude)!) as String
        
        
        let lpgr: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        lpgr.minimumPressDuration = 1.0
        //user needs to press for 1 seconds
        self.mapView.addGestureRecognizer(lpgr)
        
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
//        
//        annotation.name = (appDelegate.providerData!["ListProviderInformationSummary"]![appDelegate.providerIndex!]["name_en"]! as! String)
        
        
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
        mapView.removeFromSuperview()
        print("viewDidDisappear")
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

}
