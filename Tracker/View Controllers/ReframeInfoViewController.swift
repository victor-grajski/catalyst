//
//  ReframeInfoViewController.swift
//  Tracker
//
//  Created by Victor Grajski on 11/15/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

class ReframeInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var reframeInfoTableView: UITableView!
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.reframeInfoTableView.backgroundColor = UIColor(red: CGFloat(250/255.0), green: CGFloat(244/255.0), blue: CGFloat(242/255.0), alpha: 1.0)
        
        reframeInfoTableView.delegate = self
        reframeInfoTableView.dataSource = self
        
        let nib = UINib.init(nibName: "ReframeInfoTableViewCell", bundle: nil)
        reframeInfoTableView.register(nib, forCellReuseIdentifier: "ReframeInfoTableViewCell")

    }
    
    // MARK: - UITableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryThoughtTrapArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReframeInfoTableViewCell", for: indexPath) as! ReframeInfoTableViewCell
        
        // get index of item in thoughtTrapArray where key == entryThoughTrapArray[indexPath.item]
        for i in 0 ..< thoughtTrapArray.count  {
            if thoughtTrapArray[i].key == entryThoughtTrapArray[indexPath.item] {
                cell.commonInit(thoughtTrapArray[i].name, reframeLabelIn: thoughtTrapArray[i].trapReframe)
            }
        }
        return cell
    }

    
}
