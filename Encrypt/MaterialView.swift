//
//  MaterialView.swift
//  Encrypt
//
//  Created by Alexander Buessing on 4/26/16.
//  Copyright © 2016 Buessing. All rights reserved.
//

import UIKit

class MaterialView: UIView {

    override func awakeFromNib() {
        
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = plaster.CGColor
        
    }

}
