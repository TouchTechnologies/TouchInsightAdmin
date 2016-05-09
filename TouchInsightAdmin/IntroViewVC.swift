//
//  IntroViewVC.swift
//  TouchInsightAdmin
//
//  Created by Touch on 11/27/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import EAIntroView
import SCLAlertView
import SMPageControl



class IntroViewVC: UIViewController,EAIntroDelegate {
    @IBOutlet var beseView: UIView!
    var _intro = EAIntroView()
    var rootView = UIView()
    var page1 = EAIntroPage()
    var page2 = EAIntroPage()
    var page3 = EAIntroPage()
    var page4 = EAIntroPage()
    var page5 = EAIntroPage()
    var btnSkip = UIButton()
    var btnJoinNow = UIButton()
    
    var width = CGFloat()
    var height = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationController?.navigationBarHidden = true
        
        width = UIScreen.mainScreen().bounds.size.width
        height = UIScreen.mainScreen().bounds.size.height

        page1.title = "Welcome"
        page1.titleFont = UIFont.boldSystemFontOfSize(25.0)
        page1.titlePositionY = self.view.bounds.size.height/2 + 230;
        page1.descPositionY = self.view.bounds.size.height/2 + 190;
        page1.titleIconPositionY = self.view.bounds.size.height - 530;
        page1.desc = "Welcome to join See It Live backend editor \n application for your business"
        page1.descFont = UIFont.systemFontOfSize(15)
        page1.descColor = UIColor.grayColor()
        page1.bgColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1)
        page1.bgImage = UIImage(named: "bg1")
        
        page2.title = "Update your content"
        page2.titleFont = UIFont.boldSystemFontOfSize(20.0)
        page2.desc = "Build your content on the See It Live Thailand \n wiht backend editor application"
        page2.descFont = UIFont.systemFontOfSize(15)
        page2.bgColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1)
        page2.titlePositionY = self.view.bounds.size.height/2 + 150;
        page2.descPositionY = self.view.bounds.size.height/2 + 120;
        page2.bgImage = UIImage(named: "bg2")
        
        
        page3.title = "Property Location"
        page3.desc = "With the application can add property location \n you want to your business"
        page3.bgColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1)
        page3.titleFont = UIFont.boldSystemFontOfSize(20.0)
        page3.descFont = UIFont.systemFontOfSize(15)
        page3.titlePositionY = self.view.bounds.size.height/2 + 150;
        page3.descPositionY = self.view.bounds.size.height/2 + 120;
        page3.bgImage = UIImage(named: "bg3")
       
        
      //  let pageview = introPage4()
        
        page4 = EAIntroPage.init(customViewFromNibNamed: "introPage" )
     //   pageview.pagedetailView.frame = CGRectMake(0, height-40, width, 80)
        page4.bgColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1)
        page4.bgImage = UIImage(named: "bg4")
        
        page5.title = "Let's Start"
        page5.titleFont = UIFont.boldSystemFontOfSize(20.0)
        page5.desc = "Become a See It Live member"
        page5.descFont = UIFont.systemFontOfSize(15)
        page5.bgColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1)
        page5.titlePositionY = self.view.bounds.size.height/2 - 80;
        page5.descPositionY = self.view.bounds.size.height/2 - 110;
        page5.bgImage = UIImage(named: "bg5")
        
        btnSkip = UIButton(type: .Custom)
        btnSkip.tag = 1
        btnSkip.frame = CGRectMake(0, 0, 300, 40)
        btnSkip.setTitle("SKIP", forState: .Normal)
        btnSkip.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), forState: .Normal)
       
     
        let intro: EAIntroView = EAIntroView(frame: UIScreen.mainScreen().bounds, andPages: [page1 , page2 ,page3 ,page4,page5])
        intro.skipButton = btnSkip
        intro.skipButton.addTarget(self, action: "loadMainPage:", forControlEvents: UIControlEvents.TouchUpInside)
        intro.skipButtonY = height - 20;
        //intro.skipButton.hidden = false
        intro.pageControl.hidden = false
        intro.pageControlY = height - 40;
        intro.delegate = self
        intro.showInView(beseView, animateDuration: 0.3)

        self.page5.onPageDidDisappear = {() -> Void in
            intro.skipButton.setTitle("SKIP", forState: .Normal)
            intro.skipButton.backgroundColor = UIColor.clearColor()
            intro.skipButtonY = self.height - 40
            intro.skipButtonSideMargin = self.width + 60
            intro.pageControl.hidden = false
         //   intro.skipButton.hidden = false
        }

        self.page5.onPageDidAppear = {() -> Void in
            intro.skipButton.setTitle("JOIN NOW", forState: .Normal)
            intro.skipButton.backgroundColor = UIColor.redColor()
            intro.skipButtonY = self.view.bounds.size.height/2 - 180
            intro.skipButtonSideMargin = self.view.bounds.size.width/2 - 35
            intro.pageControl.hidden = true
            intro.swipeToExit = false
        }
      
}
    func loadMainPage(sender : UIButton)
    {
      
       let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC")
        secondViewController?.modalTransitionStyle = .CrossDissolve
        self.navigationController?.pushViewController(secondViewController!, animated: true)
    
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showIntro()
    {
        
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
