//
//  RightView.swift
//  Tracker
//
//  Created by Lex Nasser on 11/7/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

class RightView : UIViewController {

    @IBOutlet weak var graph : UIView!
    
    override func viewDidLoad ( ) {
        
        super . viewDidLoad ( )

        graph . layer . cornerRadius = 10
        
    }

}
