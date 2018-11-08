//
//  ViewController.swift
//  Tracker
//
//  Created by Lex Nasser on 11/7/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

class ViewController : UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad ( ) {
        
        super . viewDidLoad ( )
        
        let v1 = View1 ( nibName : "View1" , bundle : nil )
        self . addChild ( v1 )
        self . scrollView . addSubview ( v1 . view )
        v1 . didMove ( toParent : self )
        
        let v2 = View2 ( nibName : "View2" , bundle : nil )
        self . addChild ( v2 )
        self . scrollView . addSubview ( v2 . view )
        v2 . didMove ( toParent : self )
        
        var v2Frame : CGRect = v2 . view . frame
        v2Frame . origin . x = self . view . frame . width
        v2 . view . frame = v2Frame
        
        self . scrollView . contentSize = CGSize ( width : self . view . frame . width * 2 , height : self . view . frame . size . height )
        
        self . view . bringSubviewToFront ( headerView )
            
    }


}

