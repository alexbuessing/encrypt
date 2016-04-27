//
//  MessageComposer.swift
//  Encrypt
//
//  Created by Alexander Buessing on 4/25/16.
//  Copyright © 2016 Buessing. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    
    private var _body: String!
    
    var body: String {
        get {
            return _body
        } set (newValue) {
            _body = newValue
        }
    }
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    func configureMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        messageComposeVC.body = body
        return messageComposeVC
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
