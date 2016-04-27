//
//  TextView.swift
//  Encrypt
//
//  Created by Alexander Buessing on 4/25/16.
//  Copyright © 2016 Buessing. All rights reserved.
//

import UIKit

class TextView: UITextView {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = plaster.CGColor
        
    }

}
