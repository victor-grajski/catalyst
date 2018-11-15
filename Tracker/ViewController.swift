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
        
        let left = LeftView ( nibName : "LeftView" , bundle : nil )
        self . addChild ( left )
        self . scrollView . addSubview ( left . view )
        left . didMove ( toParent : self )
        
        let center = CenterView ( nibName : "CenterView" , bundle : nil )
        self . addChild ( center )
        self . scrollView . addSubview ( center . view )
        center . didMove ( toParent : self )
        
        let right = RightView ( nibName : "RightView" , bundle : nil )
        self . addChild ( right )
        self . scrollView . addSubview ( right . view )
        right . didMove ( toParent : self )
        
        var leftFrame : CGRect = left . view . frame
        leftFrame . origin . x = 0
        left . view . frame = leftFrame
        
        var centerFrame : CGRect = center . view . frame
        centerFrame . origin . x = self . view . frame . width
        center . view . frame = centerFrame
        
        var rightFrame : CGRect = right . view . frame
        rightFrame . origin . x = self . view . frame . width * 2
        right . view . frame = rightFrame
        
        self . scrollView . contentSize = CGSize ( width : self . view . frame . width * 3 , height : self . view . frame . size . height )
        
        self . scrollView . bounces = false
        
        //self . view . bringSubviewToFront ( headerView )
            
    }


}

