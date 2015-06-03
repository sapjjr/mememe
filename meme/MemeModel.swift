//
//  MemeModel.swift
//  meme
//
//  Created by andrew on 25/05/2015.
//  Copyright (c) 2015 Firekite. All rights reserved.
//

import Foundation
import UIKit

struct MemeModel {
    
    var topText: String!
    var bottomText: String!
    var origanalImage: UIImage!

    var memedImage: UIImage!
    
    // initialise the variables
    
    init(topText: String, bottomText: String, origanalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.origanalImage = origanalImage
        self.memedImage = memedImage
    }

}

