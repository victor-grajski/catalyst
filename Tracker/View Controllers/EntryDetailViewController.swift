//
//  EntryDetailViewController.swift
//  Tracker
//
//  Created by Victor Grajski on 11/14/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var cell1: UIView!
    @IBOutlet weak var cell2: UIView!
    @IBOutlet weak var cell3: UIView!
    
    @IBOutlet weak var entryDescriptionView: UITextView!
    @IBOutlet weak var entryThoughtTrapTableView: UITableView!
    @IBOutlet weak var entryReframeView: UITextView!
    
    @IBAction func onClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cell1 . layer . cornerRadius = 10
        cell1 . layer . shadowColor = UIColor . black . cgColor
        cell1 . layer . shadowOpacity = 0.25
        cell1 . layer . shadowOffset = CGSize . zero
        cell1 . layer . shadowRadius = 5
        cell1.backgroundColor = UIColor(red: CGFloat(250/255.0), green: CGFloat(244/255.0), blue: CGFloat(242/255.0), alpha: 1.0)

        
        cell2 . layer . cornerRadius = 10
        cell2 . layer . shadowColor = UIColor . black . cgColor
        cell2 . layer . shadowOpacity = 0.25
        cell2 . layer . shadowOffset = CGSize . zero
        cell2 . layer . shadowRadius = 5
        cell2.backgroundColor = UIColor(red: CGFloat(250/255.0), green: CGFloat(244/255.0), blue: CGFloat(242/255.0), alpha: 1.0)
        
        cell3 . layer . cornerRadius = 10
        cell3 . layer . shadowColor = UIColor . black . cgColor
        cell3 . layer . shadowOpacity = 0.25
        cell3 . layer . shadowOffset = CGSize . zero
        cell3 . layer . shadowRadius = 5
        cell3.backgroundColor = UIColor(red: CGFloat(250/255.0), green: CGFloat(244/255.0), blue: CGFloat(242/255.0), alpha: 1.0)
        
        
        
        let nib = UINib.init(nibName: "EntryDetailTrapTableViewCell", bundle: nil)
        entryThoughtTrapTableView.register(nib, forCellReuseIdentifier: "EntryDetailTrapTableViewCell")
        
        self.entryThoughtTrapTableView.backgroundColor = UIColor(red: CGFloat(250/255.0), green: CGFloat(244/255.0), blue: CGFloat(242/255.0), alpha: 1.0)
        
        entryThoughtTrapTableView.delegate = self
        entryThoughtTrapTableView.dataSource = self
        
        entryDescriptionView.text = entryDescription
        entryReframeView.text = entryReframe
    }
    
    // MARK: - UITableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryThoughtTrapArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let trapRow = tableView.dequeueReusableCell(withIdentifier: "EntryDetailTrapTableViewCell", for: indexPath) as? EntryDetailTrapTableViewCell {
            for i in 0 ..< thoughtTrapArray.count  {
                if thoughtTrapArray[i].key == entryThoughtTrapArray[indexPath.item] {
                    trapRow.commonInit(thoughtTrapArray[i].name)
                }
            }
            
            return trapRow
        }
        return UITableViewCell()
    }

}
