//
//  RestuarantInfoViewController.swift
//  TouchInsightAdmin
//
//  Created by Touch Developer on 2/23/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit

class RestuarantInfoViewController: UIViewController, SSRadioButtonControllerDelegate {
    let width = UIScreen.mainScreen().bounds.size.width
    let height = UIScreen.mainScreen().bounds.size.height
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var AlldayRadioBtn: UIButton!
    @IBOutlet var WeeklyRedioBtn: UIButton!
    @IBOutlet var StartTime24Hour : UIButton!
     var radioButtonController: SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     scrollView.contentSize = CGSizeMake(width,2050)
    self.initailRadioButton()
        
    
        // Do any additional setup after loading the view.
    }
    func initailRadioButton(){
    
        radioButtonController = SSRadioButtonsController(buttons: AlldayRadioBtn, WeeklyRedioBtn)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
    

    
    }
    func didSelectButton(aButton: UIButton?) {
        print("select redio button\(aButton)")
//            var currentButton = radioButtonController!.selectedButton()
//        print(currentButton)
        
        
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
