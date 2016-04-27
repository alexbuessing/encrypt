//
//  ButtonView.swift
//  Encrypt
//
//  Created by Alexander Buessing on 4/25/16.
//  Copyright © 2016 Buessing. All rights reserved.
//

import UIKit

class ButtonView: UIButton {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = plaster.CGColor
        
        self.layer.shadowColor = plaster.CGColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 7.0
        self.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
    }
    

}
