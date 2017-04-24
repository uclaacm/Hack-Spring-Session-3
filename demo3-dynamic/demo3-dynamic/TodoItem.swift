//
//  TodoItem.swift
//  demo3-dynamic
//
//  Created by Jahan Cherian on 4/23/17.
//  Copyright © 2017 Jahan Cherian. All rights reserved.
//

import UIKit

// This will be our default item to put into each cell

class TodoItem {
    
    var title: String
    var subtitle: String
    var image: UIImage
    
    init(title: String, subtitle: String, image: UIImage){
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
    
}
