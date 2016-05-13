//
//  InformationVC.swift
//  Encrypt
//
//  Created by Alexander Buessing on 5/12/16.
//  Copyright © 2016 Buessing. All rights reserved.
//

import UIKit

class InformationVC: UIViewController {
    
    @IBOutlet var infoText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        infoText.setContentOffset(CGPointZero, animated: false)
    }
    
}
