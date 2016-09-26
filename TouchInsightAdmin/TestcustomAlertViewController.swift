//
//  TestcustomAlertViewController.swift
//  TouchInsightAdmin
//
//  Created by Touch on 12/4/2558 BE.
//  Copyright © 2558 weerapons suwanchatree. All rights reserved.
//

import UIKit
import CustomIOSAlertView

class TestcustomAlertViewController: UIViewController ,UITextFieldDelegate {
       override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   @IBAction func launchDialog(sender: AnyObject) {
       let txtProvider = UITextField()
       txtProvider.textColor = UIColor.redColor()

        // Here we need to pass a full frame
        let alertView: CustomIOSAlertView = CustomIOSAlertView()
        // Add some custom content to the alert view
         alertView.containerView = self.createDemoView()
        // Modify the parameters
        let strArr :[String] = ["Close"]
        alertView.buttonTitles = strArr
        alertView.textInputContextIdentifier
        alertView.tag = 1
  
             //alertView.close()
    
        alertView.useMotionEffects = true
        alertView.show()
    }
    
    
    func customIOS7dialogButtonTouchUpInside(alertView: CustomIOSAlertView, clickedButtonAtIndex buttonIndex: Int) {
        NSLog("Delegate: Button at position %d is clicked on alertView %d.", buttonIndex, alertView.tag)
        alertView.close()
    }
    
    func createDemoView() -> UIView {
       
        let demoView: UIView = UIView(frame: CGRectMake(0, 0, 290, 200))
        let imageView: UIImageView = UIImageView(frame: CGRectMake(10, 10, 270, 180))
        imageView.image = UIImage(named: "demo")
        demoView.addSubview(imageView)
        return demoView
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    override func viewDidAppear(animated: Bool) {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter text:"
            textField.secureTextEntry = true
           // textField.sizeThatFits(CGSize(width: 45.0,height: 120.0))
            
            textField.backgroundColor = UIColor.redColor()
            textField.layer.borderColor = UIColor.grayColor().CGColor
            textField.layer.cornerRadius = 2.0
            textField.layer.masksToBounds = true
            textField.layer.borderWidth = 2.0
                    })
    
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
