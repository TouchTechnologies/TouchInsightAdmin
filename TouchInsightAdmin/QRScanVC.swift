//
//  QRScanVC.swift
//  TouchInsightAdmin
//
//  Created by Thirawat Phannet on 1/9/59.
//  Copyright © พ.ศ. 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

class QRScanVC: UIViewController, QRCodeReaderViewControllerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var lblShowQR: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBcakClick(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    
    
    @IBAction func scanAction(sender: AnyObject) {
        if QRCodeReader.supportsMetadataObjectTypes() {
            let reader = createReader()
            reader.modalPresentationStyle = .FormSheet
            reader.delegate               = self
            
            reader.completionBlock = { (result: QRCodeReaderResult?) in
                if let result = result {
                    self.lblShowQR.text = result.value
                    print("Completion with result: \(result.value) of type \(result.metadataType)")
                }
            }
            
            presentViewController(reader, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - QRCodeReader Delegate Methods
    func reader(reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.dismissViewControllerAnimated(true) { [weak self] in
            
            self!.lblShowQR.text = result.value

//            self!.lblShowQR.text = result.value
//            
//            let alert = UIAlertController(
//                title: "QRCodeReader",
//                message: String (format:"%@ (of type %@)", result.value, result.metadataType),
//                preferredStyle: .Alert
//            )
//            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
//            
//            self?.presentViewController(alert, animated: true, completion: nil)
            
            
        }
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func createReader() -> QRCodeReaderViewController {
        let builder = QRCodeViewControllerBuilder { builder in
            builder.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
            builder.showTorchButton = true
            //builder.showCancelButton = true
        }
        
        return QRCodeReaderViewController(builder: builder)
    }
    // MARK: - QRCodeReader Delegate Methods
}
